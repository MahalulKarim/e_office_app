import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../tugas_form/presentation/form_tugas_page.dart';
import '../controllers/tugas_tab_siang_controller.dart';
import 'item_tugas.dart';

class TugasTabSiangPage extends StatefulWidget {
  const TugasTabSiangPage({
    Key? key,
  }) : super(key: key);

  @override
  TugasTabSiangPageState createState() => TugasTabSiangPageState();
}

class TugasTabSiangPageState extends State<TugasTabSiangPage> {
  late TugasTabSiangController tugasTabSiangController;

  @override
  void initState() {
    tugasTabSiangController = Get.put(TugasTabSiangController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 45,
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/grad3.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('dd-MM-yyyy').format(DateTime.now()) ==
                                DateFormat('dd-MM-yyyy')
                                    .format(tugasTabSiangController.date)
                            ? "Hari Ini"
                            : DateFormat('dd MMMM yyyy')
                                .format(tugasTabSiangController.date),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      tugasTabSiangController.isLoading
                          ? const SizedBox()
                          : tugasTabSiangController.tugasList.data!.isEmpty
                              ? const SizedBox()
                              : Container(
                                  margin: const EdgeInsets.only(left: 3),
                                  height: 20,
                                  width: 20,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      (tugasTabSiangController
                                                      .tugasList.data!.length >
                                                  9
                                              ? "9+"
                                              : tugasTabSiangController
                                                  .tugasList.data!.length)
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                    ],
                  ),
                ),
                Expanded(
                  child: SmartRefresher(
                    controller: tugasTabSiangController.refreshController,
                    onRefresh: () async {
                      await tugasTabSiangController.initLoadData();
                    },
                    child: tugasTabSiangController.isLoading
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Spacer(),
                                CircularProgressIndicator(
                                  color: Colors.amber.shade600,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Memuat data..",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.amber.shade600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Spacer(),
                              ],
                            ),
                          )
                        : (tugasTabSiangController.tugasList.data == null ||
                                tugasTabSiangController.tugasList.data!.isEmpty)
                            ? Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Spacer(),
                                    const Icon(
                                      Icons.folder_off_rounded,
                                      size: 70,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      DateFormat('dd-MM-yyyy')
                                                  .format(DateTime.now()) ==
                                              DateFormat('dd-MM-yyyy').format(
                                                  tugasTabSiangController.date)
                                          ? "Belum upload tugas siang"
                                          : "Tidak ada upload siang",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    DateFormat('dd-MM-yyyy')
                                                .format(DateTime.now()) ==
                                            DateFormat('dd-MM-yyyy').format(
                                                tugasTabSiangController.date)
                                        ? ElevatedButton(
                                            onPressed: () {
                                              Get.to(
                                                () => const FormTugasPage(
                                                  waktuTugas: 2,
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.amber.shade600,
                                            ),
                                            child: const Text(
                                              "Kirim tugas",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...(tugasTabSiangController
                                                .tugasList.data ??
                                            [])
                                        .map((e) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ...(e.listUploadTugas ?? [])
                                              .map((val) {
                                            return ItemTugas(
                                              dataTugas: e,
                                              dataUpload: val,
                                            );
                                          }).toList(),
                                        ],
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: tugasTabSiangController.isLoading
            ? const SizedBox()
            : (tugasTabSiangController.tugasList.data == null ||
                    tugasTabSiangController.tugasList.data!.isEmpty)
                ? const SizedBox()
                : DateFormat('dd-MM-yyyy').format(DateTime.now()) ==
                        DateFormat('dd-MM-yyyy')
                            .format(tugasTabSiangController.date)
                    ? FloatingActionButton(
                        onPressed: () {
                          Get.to(
                            () => const FormTugasPage(
                              waktuTugas: 2,
                            ),
                          );
                        },
                        backgroundColor: Colors.amber.shade600,
                        foregroundColor: Colors.white,
                        child: const Icon(Icons.assignment_add),
                      )
                    : const SizedBox(),
      ),
    );
  }
}
