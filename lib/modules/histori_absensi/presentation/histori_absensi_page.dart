import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/modules/histori_absensi/controllers/histori_absensi_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common/themes/styles.dart';

class HistoriAbsensi extends StatelessWidget {
  const HistoriAbsensi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historiAbsensiController = Get.put(HistoriAbsensiController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          statusBarColor: mainColor.shade900,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        foregroundColor: mainColor,
        title: const Text("Histori Absensi"),
      ),
      body: SafeArea(child: Obx(() {
        if (historiAbsensiController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final webviewController = WebViewController();
          webviewController.loadHtmlString(
              historiAbsensiController.listAbsensi.isEmpty
                  ? "<h1>Belum ada absensi</h1>"
                  : historiAbsensiController.listAbsensi);
          return WebViewWidget(controller: webviewController);
        }
      })),
    );
  }
}
