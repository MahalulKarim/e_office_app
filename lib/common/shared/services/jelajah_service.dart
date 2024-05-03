import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/configs/config.dart';

class JelajahService extends HttpHelper {
  JelajahService() : super(baseUrl: '${Config.baseUrlOffice}/api/jelajah');

  Future<Response> getJelajah(String idUser) async {
    return await dio.post('/get_jelajah_active',
        data: FormData.fromMap({
          'X-API-KEY': '3hKnM&pQ#JCs_M',
          'id_user': idUser,
        }));
  }

  Future<Response> submitJelajah(
      bool isNew, String idUser, String lat, String lang, XFile fotoKegiatan,
      {String namaTugas = '',
      String idDetail = '',
      String keterangan = ''}) async {
    var formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'is_new': isNew ? '1' : '0',
      'nama_tugas': namaTugas,
      'id_user': idUser,
      'id_detail': idDetail,
      'lat': lat,
      'lang': lang,
      'keterangan': keterangan,
    });

    var foto = await MultipartFile.fromFile(
      fotoKegiatan.path,
      filename: fotoKegiatan.name,
    );

    formData.files.add(MapEntry(
      'foto',
      foto,
    ));

    final response = await dio.post(
      '/submit_jelajah',
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );

    return response;
  }

  Future<Response> getHasilKegiatan({
    isInifinite = false,
    int page = 1,
    int limit = 6,
  }) async {
    return await dio.post('/hasil_kegiatan',
        data: FormData.fromMap({
          'X-API-KEY': '3hKnM&pQ#JCs_M',
          'isInfinite': isInifinite ? 1 : 0,
          'page': page,
          'limit': limit,
        }));
  }
}
