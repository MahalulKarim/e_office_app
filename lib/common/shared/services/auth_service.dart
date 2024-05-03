import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/tingkat_response.dart';

import '../../models/pre_signup_response.dart';

class AuthService extends HttpHelper {
  AuthService() : super(baseUrl: '${Config.baseUrlOffice}/api/auth/');

  Future<Response> changePassword(dynamic params) async {
    final response = await dio.post(
      '/change_password',
      data: FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        ...params,
      }),
    );
    return response;
  }

  Future<Response> verifyForgotPassword(dynamic params) async {
    final response = await dio.post(
      '/forgot_password_verify',
      data: FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        ...params,
      }),
    );
    return response;
  }

  Future<Response> forgotPassword(dynamic params) async {
    final response = await dio.post(
      '/forgot_password',
      data: FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        ...params,
      }),
    );
    return response;
  }

  Future<Response> login(dynamic params) async {
    final response = await dio.post(
      '/login',
      data: FormData.fromMap({...params, 'X-API-KEY': '3hKnM&pQ#JCs_M'}),
    );
    return response;
  }

//   Future<PreSignupResponse?> preSignup() async {
//   final response = await dio.post(
//     '/data_pre_signup/',
//     data: FormData.fromMap({
//       'X-API-KEY': '3hKnM&pQ#JCs_M',
//     }),
//    options: Options(
//       // Atur batas waktu permintaan dalam milidetik menggunakan objek Duration
//       receiveTimeout: Duration(milliseconds: 15000),
//       sendTimeout: Duration(milliseconds: 15000),
//     ),
//   );

//   if (response.data == null) {
//     print('null');
//     return null;
//   } else {
//     print('ada ' );
//     return preSignupResponseFromJson(json.encode(response.data));
//   }
// }
  Future<PreSignupResponse?> preSignup() async {
    final response = await dio.post(
      '/data_pre_signup/${Config.idKantor}',
      data: FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
      }),
      options: Options(
        receiveTimeout: const Duration(milliseconds: 150000),
        sendTimeout: const Duration(milliseconds: 150000),
      ),
    );

    if (response.data == null) {
      print('null');
      return null;
    } else {
      print('ada ${json.encode(response.data)}');
      return preSignupResponseFromJson(json.encode(response.data));
    }
  }

// Dengan menambahkan log tambahan, Anda dapat melacak langkah-langkah yang dilakukan sebelum timeout terjadi dan memperoleh wawasan lebih lanjut. Jika setelah langkah-langkah ini masalah masih berlanjut, mungkin ada masalah khusus dengan server atau jaringan yang perlu diinvestigasi lebih lanjut.

  Future<Response> signup({
    required int type,
    dynamic params,
    required XFile photo,
  }) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      ...params,
      'type': type.toString(),
    });
    if (photo.path != '') {
      formData.files.add(MapEntry(
        'photo',
        await MultipartFile.fromFile(
          photo.path,
          filename: photo.name,
        ),
      ));
    }
    final response = await dio.post(
      '/signup/${Config.idKantor}',
      data: formData,
      options: Options(
        headers: {"Content-Type": "multipart/form-data"},
        responseType: ResponseType.plain,
      ),
    );

    print('yoyo${Config.idKantor}');
    return response;
  }

  Future<TingkatResponse?> getTingkat({required String idJabatan}) async {
    final response = await dio.post(
      '/get_tingkat',
      data: FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        'id_jabatan': idJabatan,
      }),
    );
    if (response.statusCode != 200) {
      return null;
    }
    return tingkatResponseFromJson(jsonEncode(response.data));
  }
}
