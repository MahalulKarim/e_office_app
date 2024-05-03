import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/agen_summary_response.dart';
import 'package:eofficeapp/common/models/referral_list_response.dart';

class AgenService extends HttpHelper {
  AgenService() : super(baseUrl: '${Config.baseUrlOffice}/api/agen');

  Future<ReferralListResponseData> getAllAffiliasi(String idUser,
      {int? page, int? limit}) async {
    final response = await dio.post('/get_referral_list',
        data: FormData.fromMap({
          "page": page ?? 1,
          "limit": limit ?? 10,
          "X-API-KEY": '3hKnM&pQ#JCs_M',
          'id_user': idUser,
        }),
        options: Options(
          responseType: ResponseType.plain,
        ));

    final resp = referralListResponseFromJson(response.data);

    return resp.data;
  }

  Future<AgenSummaryResponse> getSummary(String idUser) async {
    final response = await dio.post(
      '/get_summary',
      data: FormData.fromMap({
        "X-API-KEY": '3hKnM&pQ#JCs_M',
        "id_user": idUser,
      }),
      options: Options(
        responseType: ResponseType.plain,
      ),
    );

    return agenSummaryResponseFromJson(response.data);
  }
}
