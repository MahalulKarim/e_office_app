import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';

class MentorLaporanService extends HttpHelper {
  MentorLaporanService()
      : super(baseUrl: '${Config.baseUrlOffice}/api/mentor_laporan');

  Future<Response> getListData(
    String idPegawaiMentor,
    String startDate,
    String endDate, {
    String kodeKelas = '',
    String idPegawaiTraining = '',
    int page = 1,
    int limit = 10,
    String sort = 'desc',
  }) async {
    var data = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id_pegawai_mentor': idPegawaiMentor,
      'start_date': startDate,
      'end_date': endDate,
      'kode_kelas': kodeKelas,
      'id_pegawai_training': idPegawaiTraining,
      'page': page,
      'limit': limit,
      'sort': sort,
    });

    return await dio.post('/list_data', data: data);
  }
}
