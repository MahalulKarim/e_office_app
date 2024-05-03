import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/shared/services/portfolio_dc_response.dart';

class PortofolioService extends HttpHelper {
  PortofolioService() : super(baseUrl: '');

  Future<Response> listAllMentor(String idPegawai, String bulan,
      {String kodeKelas = '',
      String idPegawaiTraining = '',
      int page = 1,
      int limit = 10}) async {
    return dio.post('${Config.baseUrlOffice}/api/portofolio_mentor/list_all',
        data: FormData.fromMap({
          'X-API-KEY': '3hKnM&pQ#JCs_M',
          'id_pegawai_mentor': idPegawai,
          'bulan': bulan,
          'kode_kelas': kodeKelas,
          'id_pegawai_training': idPegawaiTraining,
          'page': page,
          'limit': limit,
        }));
  }

  Future<PortfolioDcResponse> getAllPortofolio(
      {int page = 1, int limit = 10}) async {
    final response = await dio.post(
      '${Config.baseUrlOffice}/api/portofolio/get_all',
      data: FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        'page': page,
        'limit': limit,
      }),
      options: Options(
        responseType: ResponseType.plain,
      ),
    );

    return portfolioDcResponseFromJson(response.data);
  }
}
