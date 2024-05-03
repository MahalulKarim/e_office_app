import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:eofficeapp/common/shared/enums/level_enum.dart';
import 'package:eofficeapp/common/shared/services/auth_service.dart';

class AuthController extends GetxController {
  final _loadingSubmit = false.obs;
  bool get loadingSubmit => _loadingSubmit.value;
  set loadingSubmit(bool value) => _loadingSubmit.value = value;

  final _userdata = {}.obs;
  get userdata => _userdata;
  set userdata(value) => _userdata.assignAll(value);

  @override
  void onInit() async {
    await checkUserdata();
    super.onInit();
  }

  Future<void> logout() async {
    userdata = {};
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  Future<dynamic> checkUserdata() async {
    const storage = FlutterSecureStorage();

    var level = await storage.read(key: 'level');
    if (level == "") {
      level = "1";
    }

    if (await storage.read(key: 'id_user') != null) {
      userdata = {
        'id_user': await storage.read(key: 'id_user'),
        'id_pegawai': await storage.read(key: 'id_pegawai'),
        'email': await storage.read(key: 'email'),
        'phone': await storage.read(key: 'phone'),
        'level': Level.values[(level is String) ? (int.parse(level) - 1) : 1],
        'id_jabatan': await storage.read(key: 'id_jabatan'),
        'foto': await storage.read(key: 'foto'),
        'foto_url': await storage.read(key: 'foto_url'),
      };
    }
    return userdata;
  }

  Future<String> login(dynamic params) async {
    final bool isConnected =
        kIsWeb ? true : await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      Get.snackbar(
        "Tidak ada koneksi internet",
        "Pastikan tersedia jaringan internet",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        icon: const Icon(Icons.offline_bolt, color: Colors.red),
        duration: const Duration(seconds: 2),
      );
      return "failed";
    }
    const storage = FlutterSecureStorage();
    final response = await AuthService().login(params);

    final parsedResponse = response.data;

    if (parsedResponse['status'] == 'ok') {
      await storage.write(
        key: 'id_user',
        value: parsedResponse['data']['id'],
      );
      await storage.write(
        key: 'id_pegawai',
        value: parsedResponse['data']['id_pegawai'],
      );
      await storage.write(
        key: 'username',
        value: parsedResponse['data']['username'],
      );
      await storage.write(
        key: 'email',
        value: parsedResponse['data']['email'],
      );
      await storage.write(
        key: 'phone',
        value: parsedResponse['data']['phone'],
      );
      await storage.write(
        key: 'level',
        value: parsedResponse['data']['level'],
      );
      await storage.write(
        key: 'id_jabatan',
        value: parsedResponse['data']['id_jabatan'],
      );
      await storage.write(
        key: 'foto',
        value: parsedResponse['data']['foto'],
      );
      await storage.write(
        key: 'foto_url',
        value: parsedResponse['data']['foto_url'],
      );

      checkUserdata();

      return "success";
    } else {
      Get.snackbar(
        "ERROR",
        "Gagal login, periksa kembali email dan password anda",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        icon: const Icon(Icons.offline_bolt, color: Colors.red),
        duration: const Duration(seconds: 2),
      );
      return "failed";
    }
  }
}
