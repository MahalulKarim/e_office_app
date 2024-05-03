import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/models/jenis_materi_response.dart';
import 'package:eofficeapp/common/models/materi_response.dart';
import 'package:eofficeapp/common/shared/services/materi_service.dart';
import 'package:flutter/material.dart';

class MateriController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();

  final _materiData = MateriData(
          items: [], meta: Meta(currentPage: 0, limit: 10, totalPages: 0))
      .obs;
  MateriData get materiData => _materiData.value;
  set materiData(MateriData value) => _materiData.value = value;

  final _materi = <Materi>[].obs;
  List<Materi> get materi => _materi.toList();
  set materi(value) => _materi.value = value;

  final _listJenisMateri = <JenisMateri>[].obs;
  List<JenisMateri> get listJenisMateri => _listJenisMateri;
  set listJenisMateri(List<JenisMateri> value) =>
      _listJenisMateri.value = value;

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  @override
  void onInit() async {
    final jenis = await MateriService().getJenisMateri();
    listJenisMateri = jenis.data;

    loadData(false);
    super.onInit();
  }

  loadData(bool? loadMore) async {
    loading = true;
    formKey.currentState?.save();

    if (loadMore == true) {
      final data = await MateriService().getMateri({
        ...formKey.currentState!.value,
        "page": materiData.meta.currentPage + 1,
      });

      materiData = data;

      materi = [...materi, ...data.items];
    } else {
      final data = await MateriService().getMateri(formKey.currentState!.value);

      materiData = data;
      materi = data.items;
    }

    loading = false;
  }

  loadMore() {
    loadData(true);
  }
}
