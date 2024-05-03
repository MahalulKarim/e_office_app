import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/controllers/user_controller.dart';
import '../../../common/controllers/gps_controller.dart';
import '../../../common/models/absen_masuk_response.dart';
import '../../../common/shared/services/absensi_service.dart';

class Absensi2Controller extends GetxController {
  late AbsensiService absensiService;
  late UserController userController;
  late GPSController gpsController;

  final _isCameraIsInitialized = false.obs;
  bool get isCameraIsInitialized => _isCameraIsInitialized.value;
  set isCameraIsInitialized(bool value) => _isCameraIsInitialized.value = value;

  final _isCameraError = false.obs;
  bool get isCameraError => _isCameraError.value;
  set isCameraError(bool value) => _isCameraError.value = value;

  final _cameraErrorMsg = "".obs;
  String get cameraErrorMsg => _cameraErrorMsg.value;
  set cameraErrorMsg(String value) => _cameraErrorMsg.value = value;

  final _locationStatement = "Tidak dapat mengetahui Lokasi".obs;
  String get locationStatement => _locationStatement.value;
  set locationStatement(String value) => _locationStatement.value = value;

  final _isOfficePosition = false.obs;
  bool get isOfficePosition => _isOfficePosition.value;
  set isOfficePosition(bool value) => _isOfficePosition.value = value;

  final _placemarkDetail = Placemark().obs;
  Placemark get placemarkDetail => _placemarkDetail.value;
  set placemarkDetail(Placemark value) => _placemarkDetail.value = value;

  final _isDhuha = 0.obs;
  int get isDhuha => _isDhuha.value;
  set isDhuha(int value) => _isDhuha.value = value;

  final _loadingSubmit = false.obs;
  bool get loadingSubmit => _loadingSubmit.value;
  set loadingSubmit(bool value) => _loadingSubmit.value = value;

  @override
  void onInit() async {
    absensiService = await Get.put(AbsensiService());
    Get.lazyPut(() => UserController());
    userController = Get.find<UserController>();
    Get.lazyPut(() => GPSController());
    gpsController = Get.find<GPSController>();
    await getPosition();
    super.onInit();
  }

  Future<bool> getPosition() async {
    final gpsPosition = await gpsController.getPosition();
    if (gpsPosition == null) {
      locationStatement = "Tidak dapat mengetahui Lokasi";
      isOfficePosition = false;
      return false;
    }
    if (gpsPosition.latitude == 0 && gpsPosition.longitude == 0) {
      locationStatement = "Tidak dapat mengetahui Lokasi";
      isOfficePosition = false;
      return false;
    }
    bool isInOffice = await gpsController.checkIsInOffice(gpsPosition);
    if (isInOffice) {
      locationStatement = "Di Kantor";
      isOfficePosition = true;
      return true;
    }
    if (kIsWeb) {
      locationStatement = "${gpsPosition.latitude}, ${gpsPosition.longitude}";
      isOfficePosition = false;
      return false;
    } else {
      placemarkDetail = await gpsController.getAddressFromPosition(gpsPosition);
      if (placemarkDetail.name != null && placemarkDetail.name != '') {
        locationStatement =
            "${placemarkDetail.street ?? ""} ${placemarkDetail.subLocality ?? ""} ${placemarkDetail.locality ?? ""} ${placemarkDetail.subAdministrativeArea ?? ""} ${placemarkDetail.country ?? ""} ${placemarkDetail.postalCode ?? ""}";
        isOfficePosition = false;
        return false;
      }
    }
    locationStatement = "Tidak Diketahui";
    isOfficePosition = false;
    return false;
  }

  Future<AbsenMasukResponse> submitMasuk(
      CameraController cameraController) async {
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    var idPegawai = await storage.read(key: 'id_pegawai');
    if (idUser == null || idPegawai == null) {
      return AbsenMasukResponse();
    }
    loadingSubmit = true;
    await getPosition();
    if (locationStatement != "Di Kantor") {
      if (userController.dataInfoUser.wfh == 1) {
      } else {
        if (userController.dataInfoUser.isWfh == 0) {
          loadingSubmit = false;
          Get.snackbar(
            "Invalid",
            "Lokasi tidak diketahui!",
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
          return AbsenMasukResponse();
        }
      }
    }
    if (locationStatement == "Tidak dapat mengetahui Lokasi") {
      loadingSubmit = false;
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
      return AbsenMasukResponse();
    }

    XFile image;
    try {
      image = await cameraController.takePicture();
    } on CameraException {
      loadingSubmit = false;
      Get.snackbar(
        "Invalid",
        "Tidak dapat mengambil Foto!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        icon: const Icon(
          Icons.camera_alt,
          color: Colors.red,
        ),
        duration: const Duration(seconds: 2),
      );
      return AbsenMasukResponse();
    }

    final response = await absensiService.absenMasuk(
        idUser, idPegawai, locationStatement, isDhuha, image);
    await userController.getInfoUser();
    loadingSubmit = false;
    if (response.statusCode != 200) {
      print(response.data.toString());
      Get.snackbar(
        "ERROR",
        "Gagal absen masuk!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        icon: const Icon(Icons.close, color: Colors.red),
        duration: const Duration(seconds: 2),
      );
      return AbsenMasukResponse();
    }
    return AbsenMasukResponse.fromJson(response.data);
  }

  Future<bool> submitPulang(CameraController cameraController) async {
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    var idPegawai = await storage.read(key: 'id_pegawai');
    if (idUser == null || idPegawai == null) {
      return false;
    }
    if (userController.dataInfoUser.totalTugasPagi == 0 &&
        userController.dataInfoUser.totalTugasSiang == 0) {
      Get.snackbar(
        "Invalid",
        "Anda belum mengunggah tugas hari ini!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        icon: const Icon(
          Icons.work_off_outlined,
          color: Colors.red,
        ),
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    loadingSubmit = true;
    await getPosition();
    if (locationStatement != "Di Kantor") {
      if (userController.dataInfoUser.wfh == 1) {
      } else {
        if (userController.dataInfoUser.isWfh == 0) {
          loadingSubmit = false;
          Get.snackbar(
            "Invalid",
            "Lokasi tidak diketahui!",
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
      }
    }
    if (locationStatement == "Tidak dapat mengetahui Lokasi") {
      loadingSubmit = false;
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

    XFile image;
    try {
      image = await cameraController.takePicture();
    } on CameraException {
      loadingSubmit = false;
      Get.snackbar(
        "Invalid",
        "Tidak dapat mengambil Foto!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        icon: const Icon(
          Icons.camera_alt,
          color: Colors.red,
        ),
        duration: const Duration(seconds: 2),
      );
      return false;
    }

    final response = await absensiService.absenPulang(
        idUser, idPegawai, locationStatement, image);
    await userController.getInfoUser();
    loadingSubmit = false;
    if (response.statusCode != 200) {
      Get.snackbar(
        "ERROR",
        response.data['msg'] ?? "Gagal absen pulang",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        icon: const Icon(Icons.close, color: Colors.red),
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    return true;
  }
}
