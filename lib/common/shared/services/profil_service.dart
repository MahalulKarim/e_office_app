import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';

class ProfilService extends HttpHelper {
  ProfilService() : super(baseUrl: '${Config.baseUrlOffice}/api/profil/');

  Future<Response> update({
    dynamic params,
    required XFile photo,
  }) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      ...params,
    });
    if (photo.path != "") {
      formData.files.add(MapEntry(
        'photo',
        await MultipartFile.fromFile(
          photo.path,
          filename: photo.name,
        ),
      ));
    }
    final response = await dio.post(
      '/update',
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );
    return response;
  }

  Future<Response> profile(String idUser) {
    return dio.post('/index',
        data: FormData.fromMap({
          "id_user": idUser,
          "X-API-KEY": '3hKnM&pQ#JCs_M',
        }));
  }
}
