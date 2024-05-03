import 'dart:io';

import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:dio/dio.dart' as d;
import 'package:eofficeapp/common/models/daily_report_response.dart';

class DailyReportService extends HttpHelper {
  DailyReportService()
      : super(baseUrl: '${Config.baseUrlOffice}/api/daily_sales_report');

  Future<d.Response> save(
      Map<String, dynamic> data, File foto, String idUser) async {
    final formData = d.FormData.fromMap(
      {
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        'id_user': idUser,
        ...data,
      },
    );

    formData.files
        .add(MapEntry('foto', await d.MultipartFile.fromFile(foto.path)));
    return dio.post('/save',
        data: formData,
        options: d.Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ));
  }

  Future<DailyReportResponse> getAll(page, limit, String idUser) async {
    final response = await dio.post(
      '/get_all',
      data: d.FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        'id_user': idUser,
        'page': page,
        'limit': limit,
      }),
      options: d.Options(
        responseType: d.ResponseType.plain,
      ),
    );

    return dailyReportResponseFromJson(response.data);
  }

  Future<DailyReport> getById(String id, String idUser) async {
    final response = await dio.post('/get_by_id',
        data: d.FormData.fromMap({
          'X-API-KEY': '3hKnM&pQ#JCs_M',
          'id_user': idUser,
          'id': id,
        }));

    print(response.data['data']);

    return DailyReport.fromJson(response.data['data']);
  }

  Future<d.Response> followUp(Map<String, dynamic> value, String idUser) {
    return dio.post('/follow_up',
        data: d.FormData.fromMap({
          ...value,
          'X-API-KEY': '3hKnM&pQ#JCs_M',
          'id_user': idUser,
        }));
  }
}
