import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:dio/dio.dart' as d;
import 'package:eofficeapp/common/models/riwayat_poin_response.dart';

class RiwayatPoinService extends HttpHelper {
  RiwayatPoinService()
      : super(baseUrl: '${Config.baseUrlOffice}/api/riwayat_poin');

  Future<RiwayatPoinData> getAll(dynamic idUser,
      {int? page, int? limit}) async {
    final response = await dio.post(
      '/get_all',
      data: d.FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        'id_user': idUser,
        'page': page,
        'limit': limit,
      }),
      options: d.Options(),
    );

    return RiwayatPoinData.fromJson(response.data['data']);
  }
}
