import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/models/tugas_response.dart';
import 'package:eofficeapp/common/shared/services/laporan_service.dart';

class LaporanController extends GetxController {
  late LaporanService _laporanService;

  final judulController = TextEditingController();
  final deskripsiController = TextEditingController();
  final keteranganTambahController = TextEditingController();

  final _jenis = 0.obs;
  int get jenis => _jenis.value;
  set jenis(int value) => _jenis.value = value;

  final _progress = 0.obs;
  int get progress => _progress.value;
  set progress(int value) => _progress.value = value;

  final _waktu = 1.obs;
  int get waktu => _waktu.value;
  set waktu(int value) => _waktu.value = value;

  final _listTugas = <Tugas>[].obs;
  List<Tugas> get listTugas => _listTugas;
  set listTugas(List<Tugas> value) => _listTugas.value = value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final _tugasSelected = "".obs;
  String get tugasSelected => _tugasSelected.value;
  set tugasSelected(String value) => _tugasSelected.value = value;

  @override
  void onInit() async {
    super.onInit();
    _laporanService = Get.put(LaporanService());
    await getTugasBelumSelesai();
  }

  Future<void> getTugasBelumSelesai() async {
    const storage = FlutterSecureStorage();
    var idPegawai = await storage.read(key: 'id_pegawai');

    if (idPegawai == null) {
      return;
    }

    isLoading = true;
    try {
      var response = await _laporanService.getTugasBelumSelesai(idPegawai);
      if (response.statusCode == 200) {
        var res = TugasResponse.fromJson(response.data);
        listTugas = res.data ?? [];
        isLoading = false;
      } else {
        isLoading = false;
        listTugas = [];
      }
    } catch (e) {
      isLoading = false;
    }
  }
}
