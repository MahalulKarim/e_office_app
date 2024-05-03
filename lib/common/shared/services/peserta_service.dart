import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/peserta_response.dart';

class PesertaService extends HttpHelper {
  PesertaService() : super(baseUrl: '${Config.baseUrlOffice}/api/peserta/');

  Future<PesertaResponse> getPeserta(int page) async {
    final peserta = await dio.post('/get_peserta',
        data: FormData.fromMap({
          'page': page.toString(),
        }),
        options: Options(
          responseType: ResponseType.plain,
        ));

    final pesertaMap = jsonDecode(peserta.data);

    return pesertaResponseFromJson(pesertaMap['data']);
  }
}
