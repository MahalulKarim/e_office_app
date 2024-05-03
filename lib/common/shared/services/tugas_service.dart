import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import '../../models/tugas_response.dart';
import '../../models/upload_tugas_response.dart';

class TugasService extends HttpHelper {
  TugasService() : super(baseUrl: '${Config.baseUrlOffice}/api/tugas/');

  Future<Response> submitTugas2({
    required String id,
    required String pathSS,
  }) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id': id,
    });
    if (pathSS != '') {
      var ss = await MultipartFile.fromFile(
        pathSS,
        filename: "ssss.png",
      );
      print("AHSGDSJ");
      print(pathSS);
      formData.files.add(MapEntry(
        'lampiran',
        ss,
      ));
    }
    final response = await dio.post(
      '/upload_tugas2',
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );
    return response;
  }

  Future<TugasResponse?> getListWithUploadNow({
    required String idPegawai,
    required int waktu,
    required String tgl,
  }) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id_pegawai': idPegawai,
      'waktu': waktu,
      'tgl': tgl,
    });
    final response = await dio.post(
      '/get_list_upload_now',
      data: formData,
    );
    if (response.statusCode != 200) {
      return null;
    }
    final parsedResponse = TugasResponse.fromJson(response.data);
    return parsedResponse;
  }

  Future<UploadTugasResponse?> getUploadById(String id) async {
    final response = await dio.post(
      '/get_upload_tugas_by_id',
      data: FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        'id': id,
      }),
    );
    if (response.statusCode != 200) {
      return null;
    }
    return uploadTugasResponseFromJson(jsonEncode(response.data));
  }

  Future<TugasResponse?> getTanggungan(String idPegawai) async {
    final response = await dio.post(
      '/get_tanggungan',
      data: FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        'id_pegawai': idPegawai,
      }),
    );
    if (response.statusCode != 200) {
      return null;
    }
    final parsedResponse = TugasResponse.fromJson(response.data);
    return parsedResponse;
  }

  Future<TugasResponse?> getTugasBelumSelesai(String idPegawai) async {
    final response = await dio.post(
      '/get_belum_selesai',
      data: FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        'id_pegawai': idPegawai,
      }),
    );
    if (response.statusCode != 200) {
      return null;
    }
    final parsedResponse = TugasResponse.fromJson(response.data);
    return parsedResponse;
  }

  Future<Response> submitSusulan({
    required String idPegawai,
    required String judul,
    required String deskripsi,
    required int progress,
    String? keterangan,
    required int waktu,
    required XFile fileLampiran,
  }) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id_pegawai': idPegawai,
      'judul': judul,
      'deskripsi': deskripsi,
      'progress': progress,
      'keterangan': keterangan,
      'waktu': waktu,
    });
    formData.files.add(MapEntry(
      'lampiran',
      await MultipartFile.fromFile(
        fileLampiran.path,
        filename: fileLampiran.name,
      ),
    ));
    final response = await dio.post(
      '/susulan',
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );
    return response;
  }

  Future<Response> submitUpload({
    required String idPegawai,
    required String id,
    required int progress,
    String? keterangan,
    required int waktu,
    required XFile fileLampiran,
  }) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id_pegawai': idPegawai,
      'id': id,
      'progress': progress,
      'keterangan': keterangan,
      'waktu': waktu,
    });
    formData.files.add(MapEntry(
      'lampiran',
      await MultipartFile.fromFile(
        fileLampiran.path,
        filename: fileLampiran.name,
      ),
    ));
    final response = await dio.post(
      '/upload',
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );
    return response;
  }

  Future<Response> submitEditUploadFull({
    required String id,
    required String judul,
    required String deskripsi,
    required int progress,
    required int waktu,
    required String keterangan,
    XFile? fileLampiran,
  }) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id': id,
      'judul': judul,
      'deskripsi': deskripsi,
      'progress': progress,
      'keterangan': keterangan,
      'waktu': waktu,
    });
    if (fileLampiran != null) {
      if (fileLampiran.path != '') {
        formData.files.add(MapEntry(
          'lampiran',
          await MultipartFile.fromFile(
            fileLampiran.path,
            filename: fileLampiran.name,
          ),
        ));
      }
    }
    final response = await dio.post(
      '/update_upload_tugas',
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );
    return response;
  }

  Future<Response> submitEditUpload({
    required String id,
    required int progress,
    String? keterangan,
    required int waktu,
    XFile? fileLampiran,
  }) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id': id,
      'progress': progress,
      'keterangan': keterangan,
      'waktu': waktu,
    });
    if (fileLampiran != null) {
      if (fileLampiran.path != '') {
        formData.files.add(MapEntry(
          'lampiran',
          await MultipartFile.fromFile(
            fileLampiran.path,
            filename: fileLampiran.name,
          ),
        ));
      }
    }
    final response = await dio.post(
      '/edit_upload',
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );
    return response;
  }

  Future<Response> deleteUpload(String id) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id': id,
    });
    final response = await dio.post(
      '/delete_upload',
      data: formData,
    );
    return response;
  }
}
