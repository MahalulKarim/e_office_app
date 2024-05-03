import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eofficeapp/common/controllers/user_controller.dart';
import 'package:eofficeapp/modules/tugas/controllers/tugas_tab_pagi_controller.dart';
import 'package:eofficeapp/modules/tugas/controllers/tugas_tab_siang_controller.dart';

import '../../../common/shared/services/tugas_service.dart';

class FormTugasController extends GetxController {
  late TugasService tugasService;
  late UserController userController;
  late TugasTabPagiController tugasTabPagiController;
  late TugasTabSiangController tugasTabSiangController;

  final _isLoadingPre = false.obs;
  bool get isLoadingPre => _isLoadingPre.value;
  set isLoadingPre(bool value) => _isLoadingPre.value = value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final _fileUrlExists = "".obs;
  String get fileUrlExists => _fileUrlExists.value;
  set fileUrlExists(String value) => _fileUrlExists.value = value;

  final _fileLampiran = XFile('').obs;
  XFile get fileLampiran => _fileLampiran.value;
  set fileLampiran(XFile value) => _fileLampiran.value = value;

  final _isSuccess = false.obs;
  bool get isSuccess => _isSuccess.value;
  set isSuccess(bool value) => _isSuccess.value = value;

  @override
  void onInit() async {
    tugasService = Get.put(TugasService());
    Get.lazyPut(() => UserController());
    userController = Get.find<UserController>();
    Get.lazyPut(() => TugasTabPagiController());
    tugasTabPagiController = Get.find<TugasTabPagiController>();
    Get.lazyPut(() => TugasTabSiangController());
    tugasTabSiangController = Get.find<TugasTabSiangController>();
    super.onInit();
  }

  Future<void> getData(String id, GlobalKey<FormBuilderState> formKey) async {
    isLoadingPre = true;
    const storage = FlutterSecureStorage();
    var idPegawai = await storage.read(key: 'id_pegawai');
    if (idPegawai == null) {
      return;
    }
    final response = await tugasService.getUploadById(id);
    isLoadingPre = false;
    if (response == null) {
      Get.back();
      return;
    }
    Future.delayed(const Duration(milliseconds: 200), () {
      formKey.currentState!.patchValue({
        'judul': response.data!.judul,
        'deskripsi': response.data!.tugas,
        'progress': response.data!.progress,
        'keterangan': response.data!.ket,
      });
      fileUrlExists = response.data!.urlFile ?? "";
    });
  }

  Future<void> submitUpdate(String id, dynamic params, int waktuTugas) async {
    isLoading = true;
    final response = await tugasService.submitEditUploadFull(
      id: id,
      judul: params['judul'],
      deskripsi: params['deskripsi'],
      progress: params['progress'] is int
          ? params['progress']
          : int.parse(params['progress']),
      waktu: waktuTugas,
      keterangan: params['keterangan'],
      fileLampiran: fileLampiran,
    );
    if (waktuTugas == 1) {
      await tugasTabPagiController.getData();
    } else {
      await tugasTabSiangController.getData();
    }
    await userController.getInfoUser();
    isLoading = false;
    if (response.statusCode == 200) {
      isSuccess = true;
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
    }
  }

  Future<void> submitSusulan(dynamic params, int waktuTugas) async {
    const storage = FlutterSecureStorage();
    var idPegawai = await storage.read(key: 'id_pegawai');
    if (idPegawai == null) {
      return;
    }
    isLoading = true;
    final response = await tugasService.submitSusulan(
      idPegawai: idPegawai,
      judul: params['judul'],
      deskripsi: params['deskripsi'],
      progress: params['progress'] is int
          ? params['progress']
          : int.parse(params['progress']),
      waktu: waktuTugas,
      keterangan: params['keterangan'],
      fileLampiran: fileLampiran,
    );
    if (waktuTugas == 1) {
      await tugasTabPagiController.getData();
    } else {
      await tugasTabSiangController.getData();
    }
    await userController.getInfoUser();
    isLoading = false;
    if (response.statusCode == 200) {
      isSuccess = true;
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
    }
  }
}
