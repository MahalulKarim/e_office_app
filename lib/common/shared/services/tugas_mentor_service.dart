import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';

class TugasMentorService extends HttpHelper {
  TugasMentorService()
      : super(baseUrl: '${Config.baseUrlOffice}/api/tugas_mentor');

  Future<Response> getList(
      {String idKelas = '0', int page = 1, int limit = 10}) async {
    var data = FormData.fromMap(
        {'X-API-KEY': '3hKnM&pQ#JCs_M', 'page': page, 'limit': limit});
    if (idKelas != '0') {
      data.fields.add(MapEntry('id_kelas_mentor', idKelas));
    }

    return await dio.post('/list', data: data);
  }

  Future<Response> getTugasUpload(String idTugas,
      {int page = 1, int limit = 10}) async {
    var data = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id_kelas': idTugas,
      'page': page,
      'limit': limit
    });

    return await dio.post('/get_tugas_upload', data: data);
  }

  Future<Response> create(Map<String, dynamic> params, File fileTugas) async {
    var data = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      ...params,
      'file': await MultipartFile.fromFile(fileTugas.path)
    });

    return await dio.post('/create', data: data);
  }

  Future<Response> update(Map<String, dynamic> params, File? fileTugas) async {
    var data = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      ...params,
    });

    if (fileTugas != null) {
      data.files.add(MapEntry(
        'file',
        await MultipartFile.fromFile(
          fileTugas.path,
        ),
      ));
    }

    return await dio.post('/update', data: data);
  }

  Future<Response> delete(String idTugas) async {
    return await dio.post('/delete',
        data: FormData.fromMap({
          'X-API-KEY': '3hKnM&pQ#JCs_M',
          'id_tugas': idTugas,
        }));
  }
}
