import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/logo_response.dart';

class LogoService extends HttpHelper {
  LogoService() : super(baseUrl: '${Config.baseUrlp}/logo_sponsor');
  Future<List<Logo>> getAll() async {
    final response = await dio.get('');
    final parsedResponse = logoFromJson(response.data);

    return parsedResponse;
  }
}
