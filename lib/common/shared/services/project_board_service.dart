import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/project_board_response.dart';

class ProjectBoardService extends HttpHelper {
  ProjectBoardService()
      : super(baseUrl: '${Config.baseUrlOffice}/api/project_board');

  Future<Response> update({
    required String id,
    required String idUser,
    required String idStatus,
  }) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id': id,
      'id_users': idUser,
      'id_status': idStatus,
    });
    final response = await dio.post(
      '/update_task_2',
      data: formData,
    );
    print('cek');

    return response;
  }

  Future<ProjectBoardDataResponse?> getData({required String idUser}) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id_users': idUser,
    });
    final response = await dio.post(
      '/get_data_2',
      // '/get_data_project',
      data: formData,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('getting task:ges ${response.data}');
      return projectBoardDataResponseFromJson(jsonEncode(response.data));
    }
    // print('cek get data2');
    return null;
  }
  // Future<ProjectBoardDataResponse?> getData2({required String idUser}) async {
  //   FormData formData = FormData.fromMap({
  //     'X-API-KEY': '3hKnM&pQ#JCs_M',
  //     'id_users': idUser,
  //   });
  //   final response = await dio.post(
  //     // '/get_data_2',
  //     '/get_data_project',
  //     data: formData,
  //   );
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     print('getting project ');
  //     return projectBoardDataResponseFromJson(jsonEncode(response.data));
  //   }
  //     // print('cek get data2');
  //   return null;
  // }
}
