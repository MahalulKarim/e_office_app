import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:eofficeapp/common/controllers/user_controller.dart';

class HomeController extends GetxController {
  final refreshController = RefreshController();
  late UserController userController;

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

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
