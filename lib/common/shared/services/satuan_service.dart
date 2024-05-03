import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';

class SatuanService extends HttpHelper {
  SatuanService() : super(baseUrl: '${Config.baseUrl}satuan');

  Future<List<dynamic>> getAll() async {
    final response = await dio.get('');
    return response.data;
  }

  Future<List<dynamic>> getBeratAll() async {
    final response = await dio.get('/get_satuan_berat');
    return response.data;
  }
}
