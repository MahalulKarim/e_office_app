import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/models/tugas_response.dart';
import 'package:eofficeapp/common/shared/services/tugas_service.dart';
import '../../../common/models/info_user_absen_response.dart';
import '../../../common/shared/services/absensi_service.dart';

class UserController extends GetxController {
  late AbsensiService absensiService;
  late TugasService tugasService;

  final _dataInfoUser = InfoUser().obs;
  InfoUser get dataInfoUser => _dataInfoUser.value;
  set dataInfoUser(InfoUser value) => _dataInfoUser.value = value;

  final _textInfo = "".obs;
  String get textInfo => _textInfo.value;
  set textInfo(String value) => _textInfo.value = value;

  final _tugasListTanggungan = TugasResponse().obs;
  TugasResponse get tugasListTanggungan => _tugasListTanggungan.value;
  set tugasListTanggungan(TugasResponse value) =>
      _tugasListTanggungan.value = value;

  @override
  void onInit() {
    Get.lazyPut(() => AbsensiService());
    absensiService = Get.find<AbsensiService>();
    Get.lazyPut(() => TugasService());
    tugasService = Get.find<TugasService>();
    super.onInit();
  }

  Future<void> initLoadData({bool force = false}) async {
    if (force) {
      await getInfoUser();
      await getInfo();
      await getTugasTanggungan();
    } else {
      const storage = FlutterSecureStorage();
      var dataInfoUserSS = await storage.read(key: 'dataInfoUser');
      if (dataInfoUserSS != null && dataInfoUserSS != "") {
        dataInfoUser = InfoUser.fromJson(jsonDecode(dataInfoUserSS));
      } else {
        await getInfoUser();
      }

      var dataInfoSs = await storage.read(key: 'dataInfo');
      if (dataInfoSs != null && dataInfoSs != "") {
        textInfo = jsonDecode(dataInfoSs)['data']['info'] ?? "";
      } else {
        await getInfo();
      }

      var dataTugasTanggunganSs =
          await storage.read(key: 'dataTugasTanggungan');
      if (dataTugasTanggunganSs != null && dataTugasTanggunganSs != "") {
        tugasListTanggungan =
            TugasResponse.fromJson(jsonDecode(dataTugasTanggunganSs));
      } else {
        await getTugasTanggungan();
      }
    }
  }

  Future<void> getInfoUser() async {
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    var idPegawai = await storage.read(key: 'id_pegawai');
    final response = await absensiService.getInfoUser(idUser!, idPegawai!);
    if (response == null) {
      return;
    }
    dataInfoUser = response.data ?? InfoUser();
    await storage.write(key: 'dataInfoUser', value: jsonEncode(response.data));
    await storage.write(
        key: 'office_latitude', value: dataInfoUser.officeLatitude.toString());
    await storage.write(
        key: 'office_longitude',
        value: dataInfoUser.officeLongitude.toString());
    await storage.write(
        key: 'office_max_distance',
        value: dataInfoUser.officeMaxDistance.toString());
  }

  Future<void> getInfo() async {
    print("info load");
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    final response = await absensiService.getInfo(idUser ?? "");
    if (response.statusCode == 200) {
      await storage.write(key: 'dataInfo', value: jsonEncode(response.data));
      final data = response.data;
      print("info${data}");
      textInfo = data['data']['info'] ?? "";
    }
  }

  Future<void> getTugasTanggungan() async {
    const storage = FlutterSecureStorage();
    var idPegawai = await storage.read(key: 'id_pegawai');
    final response = await tugasService.getTanggungan(idPegawai ?? "");
    if (response != null) {
      await storage.write(
          key: 'dataTugasTanggungan', value: jsonEncode(response.data));
      tugasListTanggungan = response;
    }
  }

  Future<void> deleteUpload(String id) async {
    final response = await tugasService.deleteUpload(id);
    await getTugasTanggungan();
    if (response.statusCode != 200) {
      return;
    }
  }
}
