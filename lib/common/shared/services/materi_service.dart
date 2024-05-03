import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/jenis_materi_response.dart';
import 'package:eofficeapp/common/models/materi_response.dart';
import 'package:dio/dio.dart';

class MateriService extends HttpHelper {
  MateriService() : super(baseUrl: '${Config.baseUrlOffice}/api/materi');

  Future<MateriData> getMateri(Map<String, dynamic> params) async {
    final response = await dio.post('/get_materi',
        data: FormData.fromMap({
          "X-API-KEY": "3hKnM&pQ#JCs_M",
          ...params,
        }));

    return MateriData.fromJson(response.data['data']);
  }

  Future<JenisMateriResponse> getJenisMateri() async {
    final response = await dio.post('/get_jenis_materi',
        data: FormData.fromMap({
          "X-API-KEY": "3hKnM&pQ#JCs_M",
        }),
        options: Options(
          responseType: ResponseType.plain,
        ));
    return jenisMateriResponseFromJson(response.data);
  }
}
