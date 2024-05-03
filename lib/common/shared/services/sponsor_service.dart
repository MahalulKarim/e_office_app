import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/sponsor_response.dart';

class SponsorService extends HttpHelper {
  SponsorService() : super(baseUrl: '${Config.baseUrlp}/slider_sponsor');
  Future<List<Sponsor>> getAll() async {
    final response = await dio.get('');
    final parsedResponse = sponsorFromJson(response.data);

    return parsedResponse;
  }
}
