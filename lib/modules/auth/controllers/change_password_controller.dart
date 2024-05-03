import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/shared/services/auth_service.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class ChangePasswordController extends GetxController {
  final _loadingSubmit = false.obs;
  bool get loadingSubmit => _loadingSubmit.value;
  set loadingSubmit(bool value) => _loadingSubmit.value = value;

  final _obscureText = true.obs;
  bool get obscureText => _obscureText.value;
  set obscureText(bool value) => _obscureText.value = value;

  Future<bool> changePass(String phone, String ncc, dynamic params) async {
    loadingSubmit = true;
    final response = await AuthService().changePassword({
      'phone': phone,
      'ncc': ncc,
      'password_new': params['password_new'],
      'password_new_confirm': params['password_new_confirm'],
    });
    loadingSubmit = false;
    if (response.statusCode == HttpStatus.created) {
      Get.snackbar(
        "Ubah password berhasil",
        "Pergantian password ke password baru berhasil!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        icon: const Icon(Icons.check_circle, color: Colors.green),
        duration: const Duration(seconds: 2),
      );
      Get.offAndToNamed('/');
      return true;
    } else {
      Get.snackbar(
        response.statusMessage.toString(),
        response.data != null
            ? response.data['message'] != null
                ? response.data['message'].toString()
                : ""
            : "",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        icon: const Icon(Icons.offline_bolt, color: Colors.red),
        duration: const Duration(seconds: 2),
      );
      return false;
    }
  }
}
