import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:eofficeapp/common/shared/services/absensi_service.dart';
import 'package:eofficeapp/common/shared/services/kata_bijak_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AbsensiController extends GetxController {
  late AbsensiService _absensiService;
  final refreshController = RefreshController();
  late KataBijakService kataBijakService;

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final _isSubmit = false.obs;
  bool get isSubmit => _isSubmit.value;
  set isSubmit(bool value) => _isSubmit.value = value;

  final _isDhuha = 0.obs;
  int get isDhuha => _isDhuha.value;
  set isDhuha(int value) => _isDhuha.value = value;

  final _positionLatitude = 0.0.obs;
  double get positionLatitude => _positionLatitude.value;
  set positionLatitude(double value) => _positionLatitude.value = value;

  final _positionLongitude = 0.0.obs;
  double get positionLongitude => _positionLongitude.value;
  set positionLongitude(double value) => _positionLongitude.value = value;

  final _locationStatement = "Tidak dapat mengetahui Lokasi".obs;
  String get locationStatement => _locationStatement.value;
  set locationStatement(String value) => _locationStatement.value = value;

  final _kalimatBijak = "".obs;
  String get kalimatBijak => _kalimatBijak.value;
  set kalimatBijak(String value) => _kalimatBijak.value = value;

  final _status = 0.obs;
  int get status => _status.value;
  set status(int value) => _status.value = value;

  final _statusTugas = 0.obs;
  int get statusTugas => _statusTugas.value;
  set statusTugas(int value) => _statusTugas.value = value;

  final _info = "".obs;
  String get info => _info.value;
  set info(String value) => _info.value = value;

  @override
  void onInit() async {
    _absensiService = await Get.put(AbsensiService());
    kataBijakService = Get.put(KataBijakService());
    getKalimat();
    await getPosition();
    await getInfo();
    await getStatus();
    super.onInit();
  }

  Future<void> getInfo() async {
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');

    final response = await _absensiService.getInfo(idUser ?? "");

    if (response.statusCode == 200) {
      final data = response.data;
      info = data['data']['info'];
    }
  }

  Future<bool> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        await Geolocator.openLocationSettings();
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openLocationSettings();
        return false;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          timeLimit: const Duration(seconds: 30));
      positionLatitude = position.latitude;
      positionLongitude = position.longitude;

      if (position.latitude == 0 && position.longitude == 0) {
        return false;
      }

      locationStatement = getLocationStatement();
    } catch (e) {
      return false;
    }

    return true;
  }

  String getLocationStatement() {
    if (positionLatitude == 0 && positionLongitude == 0) {
      return "Tidak dapat mengetahui Lokasi";
    }

    double distance = Geolocator.distanceBetween(-7.361585621696873,
        109.90770983038875, positionLatitude, positionLongitude);

    if (distance > 100) {
      return "Tidak Diketahui";
    } else {
      return "Di Kantor";
    }
  }

  Future<void> getStatus() async {
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    var idPegawai = await storage.read(key: 'id_pegawai');
    var tgl = DateFormat('dd-MM-yyyy').format(DateTime.now());

    if (idUser == null || idPegawai == null) {
      return;
    }

    isSubmit = true;
    final response = await _absensiService.getStatus(idUser, idPegawai, tgl);

    if (response.statusCode == 200) {
      isSubmit = false;
      final data = response.data;
      status = data['data']['status'] is int
          ? data['data']['status']
          : int.parse(data['data']['status']);
      statusTugas = data['data']['tugas'] is int
          ? data['data']['tugas']
          : int.parse(data['data']['tugas']);
    }
  }

  Future<bool> absenMasuk(XFile image) async {
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    var idPegawai = await storage.read(key: 'id_pegawai');
    var lokasiMasuk = locationStatement;

    if (lokasiMasuk == "Tidak dapat mengetahui Lokasi") {
      return false;
    }

    if (idUser == null || idPegawai == null) {
      return false;
    }

    isSubmit = true;

    try {
      final response = await _absensiService.absenMasuk(
          idUser, idPegawai, lokasiMasuk, isDhuha, image);
      if (response.statusCode == 201) {
        isSubmit = false;
        return true;
      } else {
        isSubmit = false;
        return false;
      }
    } catch (e) {
      isSubmit = false;
      return false;
    }
  }

  Future<bool> absenKeluar(XFile image) async {
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    var idPegawai = await storage.read(key: 'id_pegawai');
    var lokasiKeluar = locationStatement;

    if (lokasiKeluar == "Tidak dapat mengetahui Lokasi") {
      Get.snackbar(
        "ERROR",
        "Gagal mendapatkan lokasi, harap berikan perizinan lokasi",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        icon: const Icon(Icons.close, color: Colors.red),
        duration: const Duration(seconds: 2),
      );
      return false;
    }

    if (idUser == null || idPegawai == null) {
      return false;
    }

    isSubmit = true;

    try {
      final response = await _absensiService.absenPulang(
          idUser, idPegawai, lokasiKeluar, image);

      if (response.statusCode == 200) {
        isSubmit = false;
        return true;
      } else {
        Get.snackbar(
          "ERROR",
          response.data['msg'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          icon: const Icon(Icons.close, color: Colors.red),
          duration: const Duration(seconds: 2),
        );
        isSubmit = false;
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "ERROR",
        "Gagal absen pulang",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        icon: const Icon(Icons.close, color: Colors.red),
        duration: const Duration(seconds: 2),
      );
      isSubmit = false;
      return false;
    }
  }

  Future<void> getKalimat() async {
    try {
      final response = await kataBijakService.getKalimat();
      kalimatBijak = response['data']['kalimat'];
    } catch (e) {}
  }
}
