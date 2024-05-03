import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';

class KataBijakService extends HttpHelper {
  KataBijakService() : super(baseUrl: '${Config.baseUrlOffice}/api/katabijak');

  Future<dynamic> getKalimat() async {
    final response = await dio.get('');
    return response.data;
  }
}
