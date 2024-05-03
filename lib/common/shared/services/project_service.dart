import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/project_response.dart';

class ProjectService extends HttpHelper {
  ProjectService()
      : super(baseUrl: '${Config.baseUrlOffice}/api/project_board');

  Future<List<ProjectData>?> getData2({required String idUser}) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id_users': idUser,
    });
    final response = await dio.post(
      '/get_data_project',
      data: formData,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('getting project $response.data');
      return List<ProjectData>.from(
        response.data.map((x) => ProjectData.fromJson(x)),
      );
    }
    return null;
  }

  Future<void> saveData(String taskTitle, String taskDescription,
      String projectId, String? idUser, List<String>? selectedUsers) async {
    try {
      // Konversi selectedUsers menjadi List<String> jika diperlukan
      List<String> idMembers = selectedUsers ?? [];

      FormData formData = FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        'task_title': taskTitle,
        'task_description': taskDescription,
        'project_id': projectId,
        'id_users': idUser,
        'id_member': idMembers.join(
            ','), // Gabungkan daftar ID pengguna menjadi satu string dengan pemisah koma
      });

      final response = await dio.post(
        '/create_action', // Sesuaikan dengan endpoint yang benar untuk menyimpan data
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Data saved successfully');
      } else {
        print('Failed to save data: ${response.data}');
      }
    } catch (error) {
      // Handle kesalahan jika diperlukan
      print('Error saving data: $error');
    }
  }
}
