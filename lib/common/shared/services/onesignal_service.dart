import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' as g;
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/modules/auth/controllers/auth_controller.dart';

class OnesignalService extends HttpHelper {
  OnesignalService() : super(baseUrl: '${Config.baseUrlv3}/onesignal');

  Future<String> generateToken() async {
    g.Get.lazyPut(() => AuthController());
    final authController = g.Get.find<AuthController>();

    final userdata = await authController.checkUserdata();
    String userId = "";
    if (userdata['user'] != null) {
      if (userdata['user']['id'] != null) {
        userId = userdata['user']['id'].toString();
      }
    }

    const storage = FlutterSecureStorage();
    final externalId = await storage.read(key: 'external_id');

    final response = await dio.post(
      '/generate_token',
      data: FormData.fromMap({
        'id_user': userId,
        'external_id': externalId ?? '',
      }),
    );

    if (response.statusCode == 201) {
      String extId = response.data['external_id'].toString();
      await storage.write(key: 'external_id', value: extId);
      return extId;
    }

    return "";
  }
}
