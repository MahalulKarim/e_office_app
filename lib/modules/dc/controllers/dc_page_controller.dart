import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DCPageController extends GetxController {
  final _versionStr = "".obs;
  String get versionStr => _versionStr.value;
  set versionStr(String value) => _versionStr.value = value;

  @override
  void onInit() {
    getVersion();
    super.onInit();
  }

  Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionStr = "${packageInfo.version} (${packageInfo.buildNumber})";
  }
}
