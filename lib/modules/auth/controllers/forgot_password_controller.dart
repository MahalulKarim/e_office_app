import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/shared/services/auth_service.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class ForgotPasswordController extends GetxController {
  final _loadingSubmit = false.obs;
  bool get loadingSubmit => _loadingSubmit.value;
  set loadingSubmit(bool value) => _loadingSubmit.value = value;

  final _loadingVerifySubmit = false.obs;
  bool get loadingVerifySubmit => _loadingVerifySubmit.value;
  set loadingVerifySubmit(bool value) => _loadingVerifySubmit.value = value;

  Future<bool> verifyForgotPass(dynamic params) async {
    loadingVerifySubmit = true;
    final response = await AuthService().verifyForgotPassword({
      'phone': params['phone'],
      'pin': params['pin'],
    });
    loadingVerifySubmit = false;
    if (response.statusCode == HttpStatus.ok) {
      if (response.data['data']['ncc'] != null &&
          response.data['data']['ncc'] != "") {
        Get.toNamed('/change_password', arguments: {
          'phone': params['phone'],
          'ncc': response.data['data']['ncc'],
        });
        return true;
      } else {
        Get.snackbar(
          "Kendala",
          "Silahkan ulangi lagi",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          icon: const Icon(Icons.offline_bolt, color: Colors.red),
          duration: const Duration(seconds: 2),
        );
        return false;
      }
    } else {
      Get.snackbar(
        response.statusMessage.toString(),
        response.data != null
            ? response.data['msg'] != null
                ? response.data['msg'].toString()
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

  Future<bool> submitForgotPass(dynamic params) async {
    final response = await AuthService().forgotPassword({
      'phone': params['phone'],
    });
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      Get.snackbar(
        response.statusMessage.toString(),
        response.data != null
            ? response.data['msg'] != null
                ? response.data['msg'].toString()
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
