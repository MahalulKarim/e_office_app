import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:eofficeapp/common/controllers/user_controller.dart';

import '../../../common/controllers/gps_controller.dart';
import '../../../common/shared/services/absensi_service.dart';

class IzinWfhController extends GetxController {
  late GPSController gpsController;
  late AbsensiService absensiService;
  late UserController userController;

  final _locationStatement = "Tidak dapat mengetahui Lokasi".obs;
  String get locationStatement => _locationStatement.value;
  set locationStatement(String value) => _locationStatement.value = value;

  final _imgFoto = XFile('').obs;
  XFile get imgFoto => _imgFoto.value;
  set imgFoto(XFile value) => _imgFoto.value = value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final _isSuccess = false.obs;
  bool get isSuccess => _isSuccess.value;
  set isSuccess(bool value) => _isSuccess.value = value;

  @override
  void onInit() async {
    Get.lazyPut(() => GPSController());
    gpsController = Get.find<GPSController>();
    Get.lazyPut(() => AbsensiService());
    absensiService = Get.find<AbsensiService>();
    Get.lazyPut(() => UserController());
    userController = Get.find<UserController>();
    getPosition();
    super.onInit();
  }

  Future<bool> getPosition() async {
    final gpsPosition = await gpsController.getPosition();
    if (gpsPosition == null) {
      locationStatement = "Tidak dapat mengetahui Lokasi";
      return false;
    }
    if (gpsPosition.latitude == 0 && gpsPosition.longitude == 0) {
      locationStatement = "Tidak dapat mengetahui Lokasi";
      return false;
    }
    bool isInOffice = await gpsController.checkIsInOffice(gpsPosition);
    if (isInOffice) {
      locationStatement = "Di Kantor";
      return true;
    }
    locationStatement = "${gpsPosition.latitude}, ${gpsPosition.longitude}";
    return false;
  }

  Future<bool> submitWfh(dynamic params) async {
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    var idPegawai = await storage.read(key: 'id_pegawai');
    isLoading = true;
    await getPosition();
    if (locationStatement == "Tidak dapat mengetahui Lokasi") {
      isLoading = false;
      Get.snackbar(
        "Invalid",
        "Tidak dapat mengetahui Lokasi!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        icon: const Icon(
          Icons.gps_off_rounded,
          color: Colors.red,
        ),
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    String formattedDate = DateFormat('yyyy-MM-dd').format(params['tanggal']);
    final response = await absensiService.submitWfh(
      idUser: idUser!,
      idPegawai: idPegawai!,
      lokasi: locationStatement,
      tanggal: formattedDate,
      keterangan: params['keterangan'],
      foto: imgFoto,
    );
    await userController.getInfoUser();
    isLoading = false;
    if (response.statusCode == 200) {
      isSuccess = true;
      return true;
    } else {
      isSuccess = false;
      Get.snackbar(
        "ERROR",
        response.data['msg'] ?? "Error",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        icon: const Icon(Icons.close, color: Colors.red),
        duration: const Duration(seconds: 2),
      );
      return false;
    }
  }
}
