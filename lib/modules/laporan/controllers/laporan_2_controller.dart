import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:eofficeapp/common/shared/services/laporan_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../common/models/laporan_response.dart';
import '../../../common/models/laporan_total_response.dart';

class Laporan2Controller extends GetxController {
  final formatDate = DateFormat('yyyy-MM-dd');
  late LaporanService laporanService;
  final PagingController<int, TugasSimple> pagingController =
      PagingController(firstPageKey: 0);
  final refreshController = RefreshController();

  final _periodeDates = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime.now(),
  ).obs;
  DateTimeRange get periodeDates => _periodeDates.value;
  set periodeDates(DateTimeRange value) => _periodeDates.value = value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final _dataTotalRes = LaporanTotal().obs;
  LaporanTotal get dataTotalRes => _dataTotalRes.value;
  set dataTotalRes(LaporanTotal value) => _dataTotalRes.value = value;

  final _sort = "desc".obs;
  String get sort => _sort.value;
  set sort(String value) => _sort.value = value;

  @override
  void onInit() async {
    Get.lazyPut(() => LaporanService());
    laporanService = Get.find<LaporanService>();
    pagingController.addPageRequestListener((pageKey) {
      Future.delayed(Duration.zero, () {
        getData(pageKey);
      });
    });
    super.onInit();
  }

  Future<void> getData(int pageKey) async {
    isLoading = true;
    if (pageKey == 0) {
      await getTotalData();
    }
    await getListData(pageKey);
    isLoading = false;
  }

  Future<void> getTotalData() async {
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    var idPegawai = await storage.read(key: 'id_pegawai');
    final response = await laporanService.getTotalByPeriode(
      idUser: idUser ?? "",
      idPegawai: idPegawai ?? "",
      startDate: formatDate.format(periodeDates.start),
      endDate: formatDate.format(periodeDates.end),
    );
    if (response == null) {
      return;
    }
    dataTotalRes = response.data ?? LaporanTotal();
  }

  Future<void> getListData(int pageKey) async {
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    var idPegawai = await storage.read(key: 'id_pegawai');
    final response = await laporanService.getListByPeriode(
      idUser: idUser ?? "",
      idPegawai: idPegawai ?? "",
      startDate: formatDate.format(periodeDates.start),
      endDate: formatDate.format(periodeDates.end),
      page: pageKey + 1,
      limit: 20,
      sort: sort,
    );
    if (response == null) {
      pagingController.error();
      return;
    }
    if (response.data!.isLast == 1) {
      pagingController.appendLastPage(response.data!.data ?? []);
    } else {
      pagingController.appendPage(response.data!.data ?? [], pageKey + 1);
    }
  }
}
