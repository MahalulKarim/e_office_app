import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:eofficeapp/common/shared/services/tugas_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/models/tugas_response.dart';
import '../../home/controllers/home_controller.dart';

class TugasTabPagiController extends GetxController {
  late TugasService tugasService;
  late HomeController office2controller;
  final refreshController = RefreshController();

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final _tugasList = TugasResponse().obs;
  TugasResponse get tugasList => _tugasList.value;
  set tugasList(TugasResponse value) => _tugasList.value = value;

  final _date = DateTime.now().obs;
  DateTime get date => _date.value;
  set date(DateTime value) => _date.value = value;

  @override
  void onInit() async {
    tugasService = Get.put(TugasService());
    Get.lazyPut(() => HomeController());
    office2controller = Get.find<HomeController>();
    super.onInit();
  }

  Future<void> initLoadData() async {
    if (!isLoading) {
      isLoading = true;
      await getData();
      isLoading = false;
    }
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  Future<void> getData() async {
    const storage = FlutterSecureStorage();
    var idPegawai = await storage.read(key: 'id_pegawai');
    if (idPegawai == null) {
      return;
    }
    var response = await tugasService.getListWithUploadNow(
      idPegawai: idPegawai,
      waktu: 1,
      tgl: DateFormat('dd-MM-yyyy').format(date),
    );
    if (response == null) {
      return;
    }
    tugasList = response;
  }
}
