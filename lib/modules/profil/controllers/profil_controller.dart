import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eofficeapp/common/shared/services/profil_service.dart';

import '../../auth/controllers/auth_controller.dart';

class ProfilController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  late ProfilService profilService;
  late AuthController authController;

  final _urlFoto = "".obs;
  String get urlFoto => _urlFoto.value;
  set urlFoto(String value) => _urlFoto.value = value;

  final _photo = XFile('').obs;
  XFile get photo => _photo.value;
  set photo(XFile value) => _photo.value = value;

  final _loadingSubmit = false.obs;
  bool get loadingSubmit => _loadingSubmit.value;
  set loadingSubmit(bool value) => _loadingSubmit.value = value;

  final _profile = {}.obs;
  get profile => _profile;
  set profile(value) => _profile.assignAll(value);

  @override
  void onInit() {
    Get.lazyPut(() => ProfilService());
    profilService = Get.find<ProfilService>();
    Get.lazyPut(() => AuthController());
    authController = Get.find<AuthController>();
    getData();
    getProfil();
    super.onInit();
  }

  Future<dynamic> getData() async {
    const storage = FlutterSecureStorage();
    final ft = await storage.read(key: 'foto_url');
    final email = await storage.read(key: 'email');
    urlFoto = ft ?? "";
    formKey.currentState!.patchValue({
      'email': email,
    });
  }

  Future<void> getProfil() async {
    // final profil =
    //     await ProfilService().profile(authController.userdata['id_user']);
    // profile = profil.data;
  }

  Future<bool> updateData(dynamic params) async {
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    var idPegawai = await storage.read(key: 'id_pegawai');
    loadingSubmit = true;
    final response = await profilService.update(
      params: {
        ...params,
        'id_users': idUser,
        'id_pegawai': idPegawai,
      },
      photo: photo,
    );
    loadingSubmit = false;
    if (response.statusCode == 200) {
      await storage.write(
        key: 'email',
        value: response.data['data']['email'],
      );
      await storage.write(
        key: 'foto',
        value: response.data['data']['foto'],
      );
      await storage.write(
        key: 'foto_url',
        value: response.data['data']['foto_url'],
      );
      await authController.checkUserdata();
    }
    return response.statusCode == 200;
  }
}
