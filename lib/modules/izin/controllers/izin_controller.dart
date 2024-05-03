import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:eofficeapp/common/shared/services/absensi_service.dart';

class IzinController extends GetxController {
  late AbsensiService _absensiService;
  final TextEditingController tglController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final _alasan = "1".obs;
  String get alasan => _alasan.value;
  set alasan(String value) => _alasan.value = value;

  @override
  void onInit() async {
    super.onInit();
    _absensiService = await Get.put(AbsensiService());
    tglController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  Future<bool> submit(
      int status, XFile suratIzin, XFile? image, String? lokasi) async {
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    var idPegawai = await storage.read(key: 'id_pegawai');

    if (status != 0) {
      if (lokasi == null) {
        return false;
      }
      if (lokasi == "Tidak dapat mengetahui Lokasi") {
        return false;
      }
    }

    if (idUser == null || idPegawai == null) {
      return false;
    }

    isLoading = true;
    try {
      final response = await _absensiService.tidakMasuk(
        idUser,
        idPegawai,
        status,
        suratIzin,
        tglController.text,
        alasan,
        keteranganController.text,
        lokasi,
        image,
      );

      if (response.statusCode == 200) {
        isLoading = false;
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
        isLoading = false;
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "ERROR",
        "Gagal izin",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        icon: const Icon(Icons.close, color: Colors.red),
        duration: const Duration(seconds: 2),
      );
      isLoading = false;
      return false;
    }
  }
}
