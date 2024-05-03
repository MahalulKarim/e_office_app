import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';

class CekKantorService extends HttpHelper {
  CekKantorService() : super(baseUrl: '${Config.baseUrlOffice}/api/kantor/');

  Future<Response> cekIdKantor(String idKantor) async {
    final response = await dio.get('cek_kantor/$idKantor');
    return response;
  }

  Future<Response> cekKodeKantor(String kodeKantor) async {
    final response = await dio.get('cek_kode_kantor/$kodeKantor');
    return response;
  }
}
