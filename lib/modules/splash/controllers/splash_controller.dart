import 'package:get/get.dart';
import 'package:eofficeapp/common/controllers/user_controller.dart';
import 'package:eofficeapp/modules/auth/controllers/auth_controller.dart';

class SplashController extends GetxController {
  late AuthController authController;
  late UserController userController;

  @override
  void onInit() {
    Get.lazyPut(() => AuthController());
    authController = Get.find<AuthController>();
    Get.lazyPut(() => UserController());
    userController = Get.find<UserController>();
    initAuth();
    super.onInit();
  }

  Future<void> initAuth() async {
    await authController.checkUserdata();
    if (authController.userdata['id_user'] == null ||
        authController.userdata['id_user'] == "") {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Get.offAllNamed('/login');
      });
    } else {
      await userController.initLoadData(force: true);
      Future.delayed(Duration.zero, () {
        Get.offAllNamed('/');
      });
    }
  }
}
