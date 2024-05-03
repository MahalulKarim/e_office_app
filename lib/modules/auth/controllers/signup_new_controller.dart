import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eofficeapp/common/models/pre_signup_response.dart';
import 'package:eofficeapp/common/models/ro_address_response.dart';
import 'package:eofficeapp/common/models/tingkat_response.dart';
import 'package:eofficeapp/common/shared/services/auth_service.dart';
import 'package:eofficeapp/common/shared/services/ro_service.dart';

class SignUpNewController extends GetxController {
  late String idKantor;

  SignUpNewController(this.idKantor);

  final _loadingSubmit = false.obs;
  bool get loadingSubmit => _loadingSubmit.value;
  set loadingSubmit(value) => _loadingSubmit.value = value;

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(value) => _loading.value = value;

  final _formError = false.obs;
  bool get formError => _formError.value;
  set formError(value) => _formError.value = value;

  final _photo = XFile('').obs;
  XFile get photo => _photo.value;
  set photo(value) => _photo.value = value;

  final _preSignupData = PreSignupResponse().obs;
  PreSignupResponse get preSignupData => _preSignupData.value;
  set preSignupData(value) => _preSignupData.value = value;

  final _dataAddress = <RoAddress>[].obs;
  List<RoAddress> get dataAddress => _dataAddress;
  set dataAddress(List<RoAddress> value) => _dataAddress.assignAll(value);

  final _dataTingkat = <Tingkat>[].obs;
  List<Tingkat> get dataTingkat => _dataTingkat;
  set dataTingkat(List<Tingkat> value) => _dataTingkat.assignAll(value);

  final _loadingAddress = false.obs;
  bool get loadingAddress => _loadingAddress.value;
  set loadingAddress(value) => _loadingAddress.value = value;

  final _loadingTingkat = false.obs;
  bool get loadingTingkat => _loadingTingkat.value;
  set loadingTingkat(value) => _loadingTingkat.value = value;

  final _idAddress = "".obs;
  String get idAddress => _idAddress.value;
  set idAddress(value) => _idAddress.value = value;

  final _valueAddress = "".obs;
  String get valueAddress => _valueAddress.value;
  set valueAddress(value) => _valueAddress.value = value;

  Future<void> getAddress({
    required String query,
  }) async {
    loadingAddress = true;
    final response = await RoService().getAddress(query);
    loadingAddress = false;
    if (response == null) {
      dataAddress = [];
      return;
    }
    dataAddress = response.data;
  }

  Future<void> getTingkat({
    required String idJabatan,
  }) async {
    loadingTingkat = true;
    final response = await AuthService().getTingkat(idJabatan: idJabatan);
    loadingTingkat = false;
    if (response == null) {
      dataTingkat = [Tingkat(id: "", tingkat: "")];
      return;
    }
    dataTingkat = response.data ?? [Tingkat(id: "", tingkat: "")];
  }

  Future<bool> signup(dynamic params) async {
    loadingSubmit = true;
    final response = await AuthService().signup(
      type: 1,
      params: params,
      photo: photo,
    );
    loadingSubmit = false;
    if (response.statusCode == 200) {
      Get.back(result: {'msg': 'Daftar Berhasil'});
      return true;
    } else {
      Get.snackbar(
        response.statusMessage ?? "",
        "Daftar Kendala!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        icon: const Icon(Icons.offline_bolt, color: Colors.red),
        duration: const Duration(seconds: 2),
      );
      return false;
    }
  }

  @override
  void onInit() {
    preSignup();
    super.onInit();
  }

  Future<void> preSignup() async {
    loading = true;
    final response = await AuthService().preSignup();
    loading = false;
    preSignupData = response ?? PreSignupResponse();
  }
}
