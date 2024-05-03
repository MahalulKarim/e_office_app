import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/penilaian_response.dart';

class PenilaianService extends HttpHelper {
  PenilaianService() : super(baseUrl: '${Config.baseUrlOffice}/api/penilaian/');

  Future<PenilaianResponse?> getListNilai({required String idUser}) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id_users': idUser,
    });
    final response = await dio.post(
      '/get_list_nilai',
      data: formData,
    );
    if (response.statusCode != 200) {
      return null;
    }
    final parsedResponse = penilaianResponseFromJson(jsonEncode(response.data));
    return parsedResponse;
  }
}
