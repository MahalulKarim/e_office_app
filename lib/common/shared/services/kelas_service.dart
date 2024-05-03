import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';

class KelasService extends HttpHelper {
  KelasService() : super(baseUrl: '${Config.baseUrlOffice}/api/kelas');

  Future<Response> getListKelas(String idPegawaiMentor,
      {bool isInfinite = true, int page = 1, int limit = 10}) async {
    if (!isInfinite) {
      return await dio.post(
        '/get_all',
        data: FormData.fromMap({
          'X-API-KEY': '3hKnM&pQ#JCs_M',
          'id_pegawai_mentor': idPegawaiMentor,
        }),
      );
    }

    var resp = await dio.post('/list',
        data: FormData.fromMap({
          'X-API-KEY': '3hKnM&pQ#JCs_M',
          'id_pegawai_mentor': idPegawaiMentor,
          'page': page,
          'limit': limit
        }));
    return resp;
  }

  Future<Response> getListMember(String idKelas,
      {int page = 1, int limit = 10}) async {
    var resp = await dio.post('/list_member',
        data: FormData.fromMap({
          'X-API-KEY': '3hKnM&pQ#JCs_M',
          'id_kelas_mentor': idKelas,
          'page': page,
          'limit': limit
        }));
    return resp;
  }

  Future<Response> getSiswa(String idPegawai, {String kodeKelas = ''}) async {
    return await dio.post("/list_siswa",
        data: FormData.fromMap({
          'X-API-KEY': '3hKnM&pQ#JCs_M',
          'kode_kelas': kodeKelas,
          'id_pegawai_mentor': idPegawai,
        }));
  }

  Future<Response> create(Map<String, dynamic> params) async {
    return dio.post('/create',
        data: FormData.fromMap({'X-API-KEY': '3hKnM&pQ#JCs_M', ...params}));
  }

  Future<Response> update(Map<String, dynamic> params) async {
    return dio.post('/update',
        data: FormData.fromMap({'X-API-KEY': '3hKnM&pQ#JCs_M', ...params}));
  }

  Future<Response> delete(String idKelas) async {
    return dio.post('/delete',
        data: FormData.fromMap(
            {'X-API-KEY': '3hKnM&pQ#JCs_M', 'id_kelas_mentor': idKelas}));
  }
}
