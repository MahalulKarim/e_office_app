import 'package:get/get.dart';
import 'package:eofficeapp/modules/tugas/controllers/tugas_tab_pagi_controller.dart';
import 'package:eofficeapp/modules/tugas/controllers/tugas_tab_siang_controller.dart';

class TugasController extends GetxController {
  late TugasTabPagiController tugasTabPagiController;
  late TugasTabSiangController tugasTabSiangController;

  final _tabIndex = 0.obs;
  int get tabIndex => _tabIndex.value;
  set tabIndex(int value) => _tabIndex.value = value;

  final _date = DateTime.now().obs;
  DateTime get date => _date.value;
  set date(DateTime value) => _date.value = value;

  @override
  void onInit() async {
    Get.lazyPut(() => TugasTabPagiController());
    tugasTabPagiController = Get.find<TugasTabPagiController>();
    Get.lazyPut(() => TugasTabSiangController());
    tugasTabSiangController = Get.find<TugasTabSiangController>();
    super.onInit();
  }
}
