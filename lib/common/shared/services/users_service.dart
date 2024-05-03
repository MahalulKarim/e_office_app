import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/users_response.dart';

class UsersService extends HttpHelper {
  UsersService() : super(baseUrl: '${Config.baseUrlOffice}/api/project_board');

  Future<List<UsersData>?> getUserData({required String idUser}) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id_users': idUser,
    });
    final response = await dio.post(
      '/get_users',
      data: formData,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('getting User $response.data');
      return List<UsersData>.from(
        response.data.map((x) => UsersData.fromJson(x)),
      );
    }
    return null;
  }
}
