import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';

import '../../models/ads_response.dart';

class AdsService extends HttpHelper {
  AdsService() : super(baseUrl: '${Config.baseUrl}/iklan_samping');

  Future<List<Ads>> getAll() async {
    final response = await dio.get('');
    final parsedResponse = adsFromJson(response.data);

    return parsedResponse;
  }
}
