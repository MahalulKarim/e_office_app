import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';

import '../../models/info_user_absen_response.dart';

class AbsensiService extends HttpHelper {
  AbsensiService() : super(baseUrl: '${Config.baseUrlOffice}/api/absen');

  Future<Response> getListAbsensi(String idUser, String tgl) async {
    final response = await dio.post('/list_by_bulan',
        data: FormData.fromMap({
          'X-API-KEY': '3hKnM&pQ#JCs_M',
          'id_user': idUser,
          'tgl': tgl,
        }));
    return response;
  }

  Future<Response> absenMasuk(String idUser, String idPegawai,
      String lokasiMasuk, int isDhuha, XFile imageFile) async {
    final ipify = await dio.get('https://api.ipify.org');
    final ipAddress = ipify.data;

    var image = await MultipartFile.fromFile(
      imageFile.path,
      filename: imageFile.name,
    );

    var formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id_user': idUser,
      'id_pegawai': idPegawai,
      'lokasi_masuk': lokasiMasuk,
      'isDhuha': isDhuha,
      'ip_address': ipAddress,
    });

    formData.files.add(MapEntry('foto_masuk', image));

    final response = await dio.post('/in',
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}));

    return response;
  }

  Future<Response> absenPulang(String idUser, String idPegawai,
      String lokasiKeluar, XFile imageFile) async {
    final ipify = await dio.get('https://api.ipify.org');
    final ipAddress = ipify.data;

    var image = await MultipartFile.fromFile(
      imageFile.path,
      filename: imageFile.name,
    );

    var formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id_user': idUser,
      'id_pegawai': idPegawai,
      'lokasi_keluar': lokasiKeluar,
      'ip_address': ipAddress,
    });

    formData.files.add(MapEntry('foto_keluar', image));

    final response = await dio.post('/out',
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}));

    return response;
  }

  Future<Response> tidakMasuk(
      String idUser,
      String idPegawai,
      int status,
      XFile suratIzin,
      String tgl,
      String alasan,
      String keterangan,
      String? lokasiKeluar,
      XFile? imageFile) async {
    final ipify = await dio.get('https://api.ipify.org');
    final ipAddress = ipify.data;

    var formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'tgl': tgl,
      'id_user': idUser,
      'id_pegawai': idPegawai,
      'status': alasan,
      'keterangan': keterangan,
      'ip_address': ipAddress,
    });
    if (status != 0) {
      var image = await MultipartFile.fromFile(
        imageFile!.path,
        filename: imageFile.name,
      );
      formData.files.add(MapEntry('foto_keluar', image));
      formData.fields.add(MapEntry('lokasi_keluar', lokasiKeluar!));
    }

    var surat = await MultipartFile.fromFile(
      suratIzin.path,
      filename: suratIzin.name,
    );

    formData.files.add(MapEntry('surat_ijin', surat));

    final response = await dio.post(
      '/tidak_masuk',
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );

    return response;
  }

  Future<Response> submitWfh({
    required String idUser,
    required String idPegawai,
    required String lokasi,
    required String tanggal,
    required String keterangan,
    required XFile foto,
  }) async {
    final formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'id_user': idUser,
      'id_pegawai': idPegawai,
      'lokasi': lokasi,
      'tanggal': tanggal,
      'keterangan': keterangan,
    });
    formData.files.add(MapEntry(
      'foto',
      await MultipartFile.fromFile(
        foto.path,
        filename: foto.name,
      ),
    ));
    final response = await dio.post(
      '/submit_wfh',
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );
    return response;
  }

  Future<Response> getInfo(String idUser) async {
    return await dio.post(
      '/info',
      data: FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        'id_user': idUser,
      }),
    );
  }

  Future<InfoUserAbsenResponse?> getInfoUser(
      String idUser, String idPegawai) async {
    final response = await dio.post(
      '/info_user',
      data: FormData.fromMap({
        'X-API-KEY': '3hKnM&pQ#JCs_M',
        'id_user': idUser,
        'id_pegawai': idPegawai,
      }),
    );
    if (response.statusCode != 200) {
      return null;
    }
    final parsedResponse =
        infoUserAbsenResponseFromJson(jsonEncode(response.data));

    return parsedResponse;
  }

  Future<Response> getStatus(
      String idUser, String idPegawai, String tgl) async {
    return await dio.post('/get_status',
        data: FormData.fromMap({
          'X-API-KEY': '3hKnM&pQ#JCs_M',
          'id_user': idUser,
          'id_pegawai': idPegawai,
          'tgl': tgl,
        }));
  }
}
