import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';

import '../../models/laporan_response.dart';
import '../../models/laporan_total_response.dart';

class LaporanService extends HttpHelper {
  LaporanService() : super(baseUrl: '${Config.baseUrlOffice}/api/laporan');

  Future<LaporanTotalResponse?> getTotalByPeriode({
    required String idUser,
    required String idPegawai,
    required String startDate,
    required String endDate,
  }) async {
    final response = await dio.post(
      '/get_total_laporan_by_periode',
      data: FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        'id_user': idUser,
        'id_pegawai': idPegawai,
        'start_date': startDate,
        'end_date': endDate,
      }),
    );
    if (response.statusCode != 200) {
      return null;
    }
    final parsedResponse =
        laporanTotalResponseFromJson(jsonEncode(response.data));
    return parsedResponse;
  }

  Future<LaporanResponse?> getListByPeriode({
    required String idUser,
    required String idPegawai,
    required String startDate,
    required String endDate,
    required int page,
    required int limit,
    required String sort,
  }) async {
    final response = await dio.post(
      '/get_list_by_periode',
      data: FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        'id_user': idUser,
        'id_pegawai': idPegawai,
        'start_date': startDate,
        'end_date': endDate,
        'page': page,
        'limit': limit,
        'sort': sort,
      }),
    );
    if (response.statusCode != 200) {
      return null;
    }
    final parsedResponse = laporanResponseFromJson(jsonEncode(response.data));
    return parsedResponse;
  }

  Future<Response> getTugasBelumSelesai(String idPegawai) async {
    return dio.post(
      '/get_tugas_belum_selesai',
      data: FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        'id_pegawai': idPegawai,
      }),
    );
  }
}
