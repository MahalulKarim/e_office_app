import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:eofficeapp/common/shared/services/absensi_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoriAbsensiController extends GetxController {
  late AbsensiService _absensiService;
  final refreshController = RefreshController();

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final _listAbsensi = "".obs;
  String get listAbsensi => _listAbsensi.value;
  set listAbsensi(String value) => _listAbsensi.value = value;

  @override
  void onInit() async {
    Get.lazyPut(() => AbsensiService());
    _absensiService = Get.find<AbsensiService>();
    await getListAbsensi();
    super.onInit();
  }

  Future<bool> getListAbsensi() async {
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    // get date now with DateTime and format it to dd-mm-yyyy and store it to variable tgl
    var now = DateTime.now();
    final String tgl = DateFormat('dd-MM-yyyy').format(now);

    if (idUser == null) {
      return false;
    }

    isLoading = true;
    try {
      final response = await _absensiService.getListAbsensi(idUser, tgl);
      if (response.statusCode == 200) {
        listAbsensi = response.data;
        isLoading = false;
        return true;
      } else {
        isLoading = false;
        return false;
      }
    } catch (e) {
      isLoading = false;
      return false;
    }
  }
}
