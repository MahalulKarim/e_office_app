import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:eofficeapp/common/controllers/user_controller.dart';

class Laporan3Controller extends GetxController {
  final refreshController = RefreshController();
  late UserController userController;

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  final _loadingDel = false.obs;
  bool get loadingDel => _loadingDel.value;
  set loadingDel(bool value) => _loadingDel.value = value;

  final _successDel = false.obs;
  bool get successDel => _successDel.value;
  set successDel(bool value) => _successDel.value = value;

  @override
  void onInit() {
    Get.lazyPut(() => UserController());
    userController = Get.find<UserController>();
    super.onInit();
    initData();
  }

  Future<void> initData({bool force = false}) async {
    loading = true;
    await userController.initLoadData(force: force);
    loading = false;
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }
}
