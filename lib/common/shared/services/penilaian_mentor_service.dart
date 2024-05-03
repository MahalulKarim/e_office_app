import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
// import 'package:eofficeapp/common/models/penilaian_detail_response.dart';
import 'package:eofficeapp/common/models/penilaian_mentor_response.dart';
import 'package:eofficeapp/common/models/siswa_mentor_response.dart';

class PenilaianMentorService extends HttpHelper {
  PenilaianMentorService()
      : super(baseUrl: '${Config.baseUrlOffice}/api/penilaian_mentor');

  Future<PenilaianMentorResponse> getAll(
    idPegawai,
    Map<String, dynamic> params, {
    int? page,
    int? limit,
    int? idKelas,
    int? idSiswa,
  }) async {
    final response = await dio.post('/get_all',
        data: FormData.fromMap({
          'X-API-KEY': '3hKnM&pQ#JCs_M',
          "page": page,
          "limit": limit,
          "id_kelas": idKelas,
          "id_siswa": idSiswa,
          'id_pegawai': idPegawai,
          ...params,
        }),
        options: Options(
          responseType: ResponseType.plain,
        ));

    return penilaianMentorResponseFromJson(response.data);
  }

  Future<dynamic> getDetail(
      {required String idSiswa, required String tglPenilaian}) async {
    await dio.post(
      '/get_detail',
      data: FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        "id_user": idSiswa,
        "tgl_penilaian": tglPenilaian,
      }),
      options: Options(responseType: ResponseType.plain),
    );

    // return penilaianDetailResponseFromJson(response.data);
  }

  Future<SiswaMentorResponse> getSiswa(
      {required String idPegawai, String? term}) async {
    final response = await dio.post('/get_siswa',
        data: FormData.fromMap({
          'X-API-KEY': '3hKnM&pQ#JCs_M',
          "term": term,
          "id_pegawai": idPegawai,
        }),
        options: Options(
          responseType: ResponseType.plain,
        ));

    return siswaMentorResponseFromJson(response.data);
  }

  Future<Response> save(Map<String, Object> map) async {
    final response = await dio.post('/save',
        data: {
          ...map,
          'X-API-KEY': '3hKnM&pQ#JCs_M',
        },
        options: Options());
    return response;
  }

  Future<Response> update(Map<String, Object> map) async {
    final response = await dio.post('/update',
        data: {
          ...map,
          'X-API-KEY': '3hKnM&pQ#JCs_M',
        },
        options: Options());
    return response;
  }

  Future<Response> delete(
      {required String idSiswa, required String tglPenilaian}) {
    return dio.post('/delete',
        data: FormData.fromMap(
          {
            'X-API-KEY': '3hKnM&pQ#JCs_M',
            'id_siswa': idSiswa,
            'tgl_penilaian': tglPenilaian
          },
        ),
        options: Options(
          responseType: ResponseType.plain,
        ));
  }
}
