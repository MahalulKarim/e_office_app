import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/modules/laporan/controllers/laporan_print_controller.dart';

class LaporanPrintPage extends StatelessWidget {
  const LaporanPrintPage({
    Key? key,
    required this.periode,
  }) : super(key: key);

  final DateTimeRange periode;

  @override
  Widget build(BuildContext context) {
    final laporanPrintController =
        Get.put(LaporanPrintController(periodeDates: periode));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Obx(() {
            if (laporanPrintController.error) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.print_outlined,
                    size: 70,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Tidak ada data",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "Kembali",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              );
            }
            if (laporanPrintController.loading) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.print_outlined,
                    size: 70,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Mencetak laporan...",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 30,
                  ),
                ],
              );
            }
            if (laporanPrintController.loadingPrint) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.print_outlined,
                    size: 70,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Mencetak...",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  RefreshProgressIndicator(),
                  SizedBox(
                    height: 30,
                  ),
                ],
              );
            }
            if (laporanPrintController.emptyData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.folder_off_rounded,
                    size: 70,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Tidak ada upload data",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "Kembali",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.print_outlined,
                  size: 70,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    laporanPrintController.processData();
                  },
                  child: const Text(
                    "Print lagi",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text(
                    "Kembali",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
