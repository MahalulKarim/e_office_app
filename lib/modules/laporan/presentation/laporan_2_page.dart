import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:eofficeapp/common/models/laporan_response.dart';
import 'package:eofficeapp/modules/laporan/controllers/laporan_2_controller.dart';
import 'package:eofficeapp/modules/laporan/presentation/item_list_laporan.dart';
import 'package:eofficeapp/modules/laporan/presentation/laporan_print_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/themes/styles.dart';

class Laporan2Page extends StatefulWidget {
  const Laporan2Page({Key? key}) : super(key: key);

  @override
  State<Laporan2Page> createState() => _Laporan2PageState();
}

class _Laporan2PageState extends State<Laporan2Page> {
  late Laporan2Controller laporan2controller;

  @override
  void initState() {
    laporan2controller = Get.put(Laporan2Controller());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> dialogPrint() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.only(
              top: 12,
              left: 8,
              right: 8,
              bottom: 8,
            ),
            title: const Text("Lanjut Print?"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "BATAL",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.to(
                    () => LaporanPrintPage(
                      periode: laporan2controller.periodeDates,
                    ),
                  );
                },
                child: const Text("PRINT"),
              ),
            ],
          );
        },
      );
    }

    Future<void> dialogInfo() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: const SizedBox(
              child: Text("LAPORAN"),
            ),
            content: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          laporan2controller.periodeDates.start
                              .toIso8601String()
                              .substring(0, 10),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          laporan2controller.periodeDates.end
                              .toIso8601String()
                              .substring(0, 10),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 130,
                        child: Text("TOTAL MASUK"),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            (laporan2controller.dataTotalRes.totalMasuk ?? "")
                                .toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 130,
                        child: Text("TOTAL PULANG"),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            (laporan2controller.dataTotalRes.totalPulang ?? "")
                                .toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 130,
                        child: Text("TOTAL IZIN"),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            (laporan2controller.dataTotalRes.totalIzin ?? "")
                                .toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 130,
                        child: Text("TOTAL SAKIT"),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            (laporan2controller.dataTotalRes.totalSakit ?? "")
                                .toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 130,
                        child: Text("TOTAL WFH"),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            (laporan2controller.dataTotalRes.totalWfh ?? "")
                                .toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 130,
                        child: Text("TOTAL TUGAS"),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            (laporan2controller.dataTotalRes.totalTugas ?? "")
                                .toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "KEMBALI",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    Future<void> dialogSort() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.only(
              top: 12,
              left: 8,
              right: 8,
              bottom: 8,
            ),
            title: const Text("Urutkan"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: laporan2controller.isLoading
                      ? null
                      : () {
                          if (laporan2controller.sort == "desc") {
                            Get.back();
                            return;
                          }
                          laporan2controller.sort = "desc";
                          laporan2controller.pagingController.refresh();
                          laporan2controller.refreshController
                              .refreshCompleted();
                          laporan2controller.refreshController.loadComplete();
                          Get.back();
                        },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      laporan2controller.sort == "desc"
                          ? Icon(
                              Icons.check_circle_outline_outlined,
                              color: mainColor,
                            )
                          : const Icon(
                              Icons.circle_outlined,
                              color: Colors.grey,
                            ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          "Akhir Tanggal",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: laporan2controller.isLoading
                      ? null
                      : () {
                          if (laporan2controller.sort == "asc") {
                            Get.back();
                            return;
                          }
                          laporan2controller.sort = "asc";
                          laporan2controller.pagingController.refresh();
                          laporan2controller.refreshController
                              .refreshCompleted();
                          laporan2controller.refreshController.loadComplete();
                          Get.back();
                        },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      laporan2controller.sort == "asc"
                          ? Icon(
                              Icons.check_circle_outline_outlined,
                              color: mainColor,
                            )
                          : const Icon(
                              Icons.circle_outlined,
                              color: Colors.grey,
                            ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          "Awal Tanggal",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
            statusBarColor: mainColor.shade900,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black,
          ),
          title: const Text("Laporan"),
          foregroundColor: Colors.blueGrey.shade600,
          backgroundColor: Colors.white,
          elevation: 2,
          actions: [
            IconButton(
              onPressed: laporan2controller.isLoading
                  ? null
                  : () {
                      dialogPrint();
                    },
              icon: const Icon(
                Icons.print,
                color: Colors.blueGrey,
              ),
            ),
            IconButton(
              onPressed: laporan2controller.isLoading
                  ? null
                  : () {
                      dialogInfo();
                    },
              icon: const Icon(
                Icons.info_outlined,
                color: Colors.blueGrey,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              padding: const EdgeInsets.only(
                top: 7,
                bottom: 7,
                left: 12,
                right: 4,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderDateRangePicker(
                      name: 'periode',
                      firstDate: DateTime(DateTime.now().year - 10),
                      lastDate: DateTime.now(),
                      initialValue: laporan2controller.periodeDates,
                      format: laporan2controller.formatDate,
                      enabled: !laporan2controller.isLoading,
                      initialEntryMode: DatePickerEntryMode.calendar,
                      decoration: InputDecoration(
                        labelText: '',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: 12,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        prefixIcon: laporan2controller.isLoading
                            ? const Icon(
                                Icons.more_horiz_rounded,
                                color: Colors.grey,
                                size: 32,
                              )
                            : const Icon(
                                CupertinoIcons.calendar,
                                color: Colors.blueGrey,
                                size: 32,
                              ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        laporan2controller.periodeDates = value;
                        laporan2controller.pagingController.refresh();
                        laporan2controller.refreshController.refreshCompleted();
                        laporan2controller.refreshController.loadComplete();
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: laporan2controller.isLoading
                        ? null
                        : () {
                            dialogSort();
                          },
                    icon: Icon(
                      laporan2controller.sort == "desc"
                          ? CupertinoIcons.sort_down
                          : CupertinoIcons.sort_up,
                      color: Colors.blueGrey,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SmartRefresher(
            controller: laporan2controller.refreshController,
            onRefresh: () {
              laporan2controller.pagingController.refresh();
              laporan2controller.refreshController.refreshCompleted();
              laporan2controller.refreshController.loadComplete();
            },
            child: PagedListView(
              pagingController: laporan2controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<TugasSimple>(
                itemBuilder: (context, item, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      1 ==
                              (laporan2controller.sort == "desc"
                                  ? item.isDividerLastMonth
                                  : item.isDividerFirstMonth)
                          ? Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${item.textMonth != null ? item.textMonth!.toUpperCase() : ""} ${item.year != null ? item.year!.toUpperCase() : ""}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      letterSpacing: 0.6,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Expanded(
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      ItemListLaporan(item: item),
                      1 ==
                              (laporan2controller.sort == "desc"
                                  ? item.isDividerFirstMonth
                                  : item.isDividerLastMonth)
                          ? Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${item.textMonth != null ? item.textMonth!.toUpperCase() : ""} ${item.year != null ? item.year!.toUpperCase() : ""}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      letterSpacing: 0.6,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Expanded(
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                    ],
                  );
                },
                noItemsFoundIndicatorBuilder: (context) {
                  return const SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_off_rounded,
                          size: 70,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Tidak ada upload data",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
