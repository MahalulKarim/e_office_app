import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../tugas_form/presentation/form_tugas_page.dart';
import '../controllers/tugas_tab_pagi_controller.dart';
import 'item_tugas.dart';

class TugasTabPagiPage extends StatefulWidget {
  const TugasTabPagiPage({
    Key? key,
  }) : super(key: key);

  @override
  TugasTabPagiPageState createState() => TugasTabPagiPageState();
}

class TugasTabPagiPageState extends State<TugasTabPagiPage> {
  late TugasTabPagiController tugasTabPagiController;

  @override
  void initState() {
    tugasTabPagiController = Get.put(TugasTabPagiController());
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
                      image: AssetImage('assets/grad4.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('dd-MM-yyyy').format(DateTime.now()) ==
                                DateFormat('dd-MM-yyyy')
                                    .format(tugasTabPagiController.date)
                            ? "Hari Ini"
                            : DateFormat('dd MMMM yyyy')
                                .format(tugasTabPagiController.date),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      tugasTabPagiController.isLoading
                          ? const SizedBox()
                          : tugasTabPagiController.tugasList.data!.isEmpty
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
                                      (tugasTabPagiController
                                                      .tugasList.data!.length >
                                                  9
                                              ? "9+"
                                              : tugasTabPagiController
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
                    controller: tugasTabPagiController.refreshController,
                    onRefresh: () async {
                      await tugasTabPagiController.initLoadData();
                    },
                    child: tugasTabPagiController.isLoading
                        ? const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Spacer(),
                                CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Memuat data..",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Spacer(),
                              ],
                            ),
                          )
                        : (tugasTabPagiController.tugasList.data == null ||
                                tugasTabPagiController.tugasList.data!.isEmpty)
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
                                                  tugasTabPagiController.date)
                                          ? "Belum upload tugas pagi"
                                          : "Tidak ada upload pagi",
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
                                                tugasTabPagiController.date)
                                        ? ElevatedButton(
                                            onPressed: () {
                                              Get.to(
                                                () => const FormTugasPage(
                                                  waktuTugas: 1,
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
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
                                    ...(tugasTabPagiController.tugasList.data ??
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
        floatingActionButton: tugasTabPagiController.isLoading
            ? const SizedBox()
            : (tugasTabPagiController.tugasList.data == null ||
                    tugasTabPagiController.tugasList.data!.isEmpty)
                ? const SizedBox()
                : DateFormat('dd-MM-yyyy').format(DateTime.now()) ==
                        DateFormat('dd-MM-yyyy')
                            .format(tugasTabPagiController.date)
                    ? FloatingActionButton(
                        onPressed: () {
                          Get.to(
                            () => const FormTugasPage(
                              waktuTugas: 1,
                            ),
                          );
                        },
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        child: const Icon(Icons.assignment_add),
                      )
                    : const SizedBox(),
      ),
    );
  }
}
