import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eofficeapp/common/controllers/user_controller.dart';

import '../../../common/models/tugas_response.dart';
import '../../../common/shared/services/tugas_service.dart';

class FormTugasTanggunganController extends GetxController {
  FormTugasTanggunganController({
    Key? key,
    this.id,
    this.idTugas,
  });

  final String? id;
  final String? idTugas;

  late TugasService tugasService;
  final formKey = GlobalKey<FormBuilderState>();
  late UserController userController;

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final _listTugas = <Tugas>[].obs;
  List<Tugas> get listTugas => _listTugas;
  set listTugas(List<Tugas> value) => _listTugas.value = value;

  final _infoTugas = ''.obs;
  String get infoTugas => _infoTugas.value;
  set infoTugas(String value) => _infoTugas.value = value;

  final _fileLampiran = XFile('').obs;
  XFile get fileLampiran => _fileLampiran.value;
  set fileLampiran(XFile value) => _fileLampiran.value = value;

  final _urlEditFile = ''.obs;
  String get urlEditFile => _urlEditFile.value;
  set urlEditFile(String value) => _urlEditFile.value = value;

  final _isLoadingSubmit = false.obs;
  bool get isLoadingSubmit => _isLoadingSubmit.value;
  set isLoadingSubmit(bool value) => _isLoadingSubmit.value = value;

  final _isSuccess = false.obs;
  bool get isSuccess => _isSuccess.value;
  set isSuccess(bool value) => _isSuccess.value = value;

  @override
  void onInit() async {
    tugasService = Get.put(TugasService());
    Get.lazyPut(() => UserController());
    userController = Get.find<UserController>();
    initLoadData();
    super.onInit();
  }

  Future<void> initLoadData() async {
    isLoading = true;
    await getTanggungan();
    if (id != null && id != '') {
      await getUploadTugas();
    }
    isLoading = false;
    setPatchValue();
  }

  setPatchValue() {
    if (idTugas != null) {
      Future.delayed(const Duration(milliseconds: 200), () {
        formKey.currentState!.patchValue({'id': idTugas});
      });
    }
  }

  formReset() {
    isSuccess = false;
    formKey.currentState!.reset();
    setPatchValue();
  }

  Future<void> getUploadTugas() async {
    final response = await tugasService.getUploadById(id ?? "");
    if (response == null) {
      Get.back();
      return;
    }
    Future.delayed(const Duration(milliseconds: 200), () {
      formKey.currentState!.patchValue({
        'id': response.data!.idTugas.toString(),
        'keterangan': response.data!.ket.toString(),
      });
    });
    urlEditFile = response.data!.urlFile.toString();
  }

  Future<void> getTanggungan() async {
    const storage = FlutterSecureStorage();
    var idPegawai = await storage.read(key: 'id_pegawai');
    if (idPegawai == null) {
      return;
    }
    var response = await tugasService.getTanggungan(idPegawai);
    if (response == null) {
      return;
    }
    listTugas = response.data ?? [];
  }

  Future<void> submitUpload(dynamic params) async {
    const storage = FlutterSecureStorage();
    var idPegawai = await storage.read(key: 'id_pegawai');
    if (idPegawai == null) {
      return;
    }
    isLoadingSubmit = true;
    final response = await tugasService.submitUpload(
      idPegawai: idPegawai,
      id: params['id'],
      progress: 100,
      waktu: 3,
      keterangan: params['keterangan'],
      fileLampiran: fileLampiran,
    );
    await userController.getTugasTanggungan();
    isLoadingSubmit = false;
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

  Future<void> submitEditUpload(dynamic params) async {
    isLoadingSubmit = true;
    final response = await tugasService.submitEditUpload(
      id: id ?? "",
      progress: 100,
      waktu: 3,
      keterangan: params['keterangan'],
      fileLampiran: fileLampiran,
    );
    await userController.getTugasTanggungan();
    isLoadingSubmit = false;
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

  Future<void> save(dynamic params) async {
    if (id != null && id != '') {
      submitEditUpload(params);
    } else {
      submitUpload(params);
    }
  }
}
