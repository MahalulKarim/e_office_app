import 'package:accordion/accordion.dart';
import 'package:eofficeapp/modules/logo-banner/logo_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:eofficeapp/modules/auth/controllers/auth_controller.dart';
import 'package:eofficeapp/modules/laporan/controllers/laporan_3_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../common/themes/styles.dart';
import '../../laporan/presentation/laporan_2_page.dart';
import '../../tugas/presentation/tugas_page.dart';
import '../../tugas_form/presentation/form_tugas_tanggungan_page.dart';

class Laporan3Page extends StatefulWidget {
  const Laporan3Page({Key? key}) : super(key: key);

  @override
  State<Laporan3Page> createState() => _Laporan3PageState();
}

class _Laporan3PageState extends State<Laporan3Page> {
  late Laporan3Controller controller;
  late AuthController authController;

  @override
  void initState() {
    controller = Get.put(Laporan3Controller());
    Get.lazyPut(() => AuthController());
    authController = Get.find<AuthController>();
    super.initState();
  }

  dialogDelete(String upTugasId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Obx(() {
          if (controller.successDel) {
            return AlertDialog(
              title: const Text("Pesan"),
              content: const Text("Hapus berhasil!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    "OKE",
                  ),
                ),
              ],
            );
          }
          if (controller.loadingDel) {
            return const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
          return AlertDialog(
            title: const Text("Konfirmasi hapus"),
            content: const Text(
                "Ingin hapus tugas tanggungan yang sudah di upload?"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "TIDAK",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  controller.userController.deleteUpload(upTugasId);
                },
                child: const Text(
                  "YA, HAPUS",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        });
      },
    ).then((value) {
      controller.successDel = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: SmartRefresher(
                    controller: controller.refreshController,
                    onRefresh: () async {
                      await controller.initData(force: true);
                      controller.refreshController.refreshCompleted();
                      controller.refreshController.loadComplete();
                    },
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              child: Image.asset(
                                'assets/img_logo.png',
                                height: 140,
                              ),
                            ),
                            controller.loading
                                ? const SizedBox()
                                : controller.userController.dataInfoUser
                                            .statusTidakMasuk ==
                                        1
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.time_to_leave_rounded,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              "Izin",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : controller.userController.dataInfoUser
                                                .statusTidakMasuk ==
                                            2
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                              horizontal: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.deepOrange,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.sick_outlined,
                                                  size: 18,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 6,
                                                ),
                                                Text(
                                                  "Sakit",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : controller.userController.dataInfoUser
                                                    .statusTidakMasuk ==
                                                3
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 4,
                                                  horizontal: 8,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.close_rounded,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(
                                                      "Alpha",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : controller
                                                        .userController
                                                        .dataInfoUser
                                                        .statusTidakMasuk ==
                                                    4
                                                ? Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 4,
                                                      horizontal: 8,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .home_work_outlined,
                                                          size: 18,
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Text(
                                                          "WFH",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox(),
                            SizedBox(
                              height: controller.loading ? 0 : 12,
                            ),
                            controller.loading
                                ? Column(
                                    children: [
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Shimmer(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.blue[400]!,
                                            Colors.blue[900]!,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Accordion(
                                    maxOpenSections: 5,
                                    paddingListTop: 10,
                                    disableScrolling: true,
                                    headerBackgroundColor: Colors.blue.shade800,
                                    contentBorderColor: Colors.blue.shade800,
                                    contentBackgroundColor:
                                        Colors.blue.shade100,
                                    paddingListHorizontal: 0,
                                    scaleWhenAnimating: false,
                                    children: [
                                      AccordionSection(
                                        isOpen: true,
                                        headerBorderRadius: 14,
                                        contentBorderRadius: 14,
                                        headerPadding: const EdgeInsets.all(10),
                                        leftIcon: Container(
                                          height: 28,
                                          width: 28,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            LineIcons.accusoft,
                                            color: mainColor,
                                          ),
                                        ),
                                        header: const Text(
                                          'Laporan',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        content: SizedBox(
                                          width: double.infinity,
                                          child: Wrap(
                                            children: [
                                              TextButton.icon(
                                                onPressed: () {
                                                  Get.to(
                                                    () => const TugasPage(
                                                      waktuTugas: 1,
                                                    ),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.assignment_add,
                                                  color: Colors.blue.shade600,
                                                ),
                                                label: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "Tugas Pagi",
                                                      style: TextStyle(
                                                        color: Colors
                                                            .brown.shade700,
                                                      ),
                                                    ),
                                                    (controller
                                                                    .userController
                                                                    .dataInfoUser
                                                                    .totalTugasPagi ??
                                                                0) >
                                                            0
                                                        ? Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 3),
                                                            height: 17,
                                                            width: 17,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.blue,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                ((controller.userController.dataInfoUser.totalTugasPagi ??
                                                                                0) >
                                                                            9
                                                                        ? "9+"
                                                                        : controller
                                                                            .userController
                                                                            .dataInfoUser
                                                                            .totalTugasPagi)
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : const Icon(
                                                            Icons.close_rounded,
                                                            color: Colors.red,
                                                            size: 16,
                                                          ),
                                                  ],
                                                ),
                                              ),
                                              TextButton.icon(
                                                onPressed: () {
                                                  Get.to(
                                                    () => const TugasPage(
                                                      waktuTugas: 2,
                                                    ),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons
                                                      .assignment_returned_rounded,
                                                  color: Colors.blue.shade600,
                                                ),
                                                label: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "Tugas Siang",
                                                      style: TextStyle(
                                                        color: Colors
                                                            .brown.shade700,
                                                      ),
                                                    ),
                                                    (controller
                                                                    .userController
                                                                    .dataInfoUser
                                                                    .totalTugasSiang ??
                                                                0) >
                                                            0
                                                        ? Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 3),
                                                            height: 17,
                                                            width: 17,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.blue,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                ((controller.userController.dataInfoUser.totalTugasSiang ??
                                                                                0) >
                                                                            9
                                                                        ? "9+"
                                                                        : controller
                                                                            .userController
                                                                            .dataInfoUser
                                                                            .totalTugasSiang)
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : const Icon(
                                                            Icons.close_rounded,
                                                            color: Colors.red,
                                                            size: 16,
                                                          ),
                                                  ],
                                                ),
                                              ),
                                              TextButton.icon(
                                                onPressed: () {
                                                  Get.to(() =>
                                                      const Laporan2Page());
                                                },
                                                icon: Icon(
                                                  Icons.print_rounded,
                                                  color: Colors.blue.shade600,
                                                ),
                                                label: Text(
                                                  "Cetak Laporan",
                                                  style: TextStyle(
                                                    color: Colors.blue.shade700,
                                                  ),
                                                ),
                                              ),
                                              controller
                                                          .userController
                                                          .dataInfoUser
                                                          .certificate !=
                                                      1
                                                  ? const SizedBox()
                                                  : TextButton.icon(
                                                      onPressed: () {
                                                        launchUrlString(
                                                          controller
                                                                  .userController
                                                                  .dataInfoUser
                                                                  .certificateUrl ??
                                                              "",
                                                          mode: LaunchMode
                                                              .inAppWebView,
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.download_rounded,
                                                        color: Colors
                                                            .brown.shade600,
                                                      ),
                                                      label: Text(
                                                        "Unduh Sertifikat",
                                                        style: TextStyle(
                                                          color: Colors
                                                              .brown.shade700,
                                                        ),
                                                      ),
                                                    ),
                                              controller
                                                          .userController
                                                          .dataInfoUser
                                                          .penilaian ==
                                                      1
                                                  ? TextButton.icon(
                                                      onPressed: () {
                                                        Get.toNamed(
                                                            '/penilaian');
                                                      },
                                                      icon: Icon(
                                                        Icons.assessment,
                                                        color: Colors
                                                            .brown.shade600,
                                                      ),
                                                      label: Text(
                                                        "Penilaian",
                                                        style: TextStyle(
                                                          color: Colors
                                                              .brown.shade700,
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if ((controller
                                                  .userController
                                                  .dataInfoUser
                                                  .totalTanggungan ??
                                              0) >
                                          0)
                                        AccordionSection(
                                          isOpen: true,
                                          headerBorderRadius: 14,
                                          contentBorderRadius: 14,
                                          contentVerticalPadding: 0,
                                          headerPadding:
                                              const EdgeInsets.all(10),
                                          leftIcon: Container(
                                            height: 28,
                                            width: 28,
                                            decoration: const BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              LineIcons.archive,
                                              color: mainColor,
                                            ),
                                          ),
                                          header: const Text(
                                            'Tanggungan',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                            ),
                                          ),
                                          content: Container(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ...(controller
                                                            .userController
                                                            .tugasListTanggungan
                                                            .data ??
                                                        [])
                                                    .map((e) {
                                                  return Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 6,
                                                      horizontal: 12,
                                                    ),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 8),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          Colors.grey.shade100,
                                                    ),
                                                    child: SizedBox(
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        CupertinoIcons
                                                                            .square_list_fill,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade500,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            6,
                                                                      ),
                                                                      Text(
                                                                        e.judul ??
                                                                            "",
                                                                        style:
                                                                            TextStyle(
                                                                          color: Colors
                                                                              .brown
                                                                              .shade700,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                (e.listUploadTugas !=
                                                                            null &&
                                                                        e.listUploadTugas!
                                                                            .isNotEmpty)
                                                                    ? const SizedBox()
                                                                    : TextButton
                                                                        .icon(
                                                                        onPressed:
                                                                            () {
                                                                          Get.to(
                                                                            () =>
                                                                                FormTugasTanggunganPage(
                                                                              idTugas: e.id.toString(),
                                                                            ),
                                                                          );
                                                                        },
                                                                        icon: const Icon(
                                                                            Icons.upload_file_outlined),
                                                                        label: const Text(
                                                                            "Upload"),
                                                                      )
                                                              ],
                                                            ),
                                                          ),
                                                          (e.listUploadTugas !=
                                                                      null &&
                                                                  e.listUploadTugas!
                                                                      .isNotEmpty)
                                                              ? const SizedBox(
                                                                  height: 4,
                                                                )
                                                              : const SizedBox(),
                                                          ...(e.listUploadTugas ??
                                                                  [])
                                                              .map((val) {
                                                            return GestureDetector(
                                                              onTap: () {
                                                                return;
                                                              },
                                                              child: Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 6),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  vertical: 6,
                                                                  horizontal:
                                                                      12,
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            val.tgl ??
                                                                                "",
                                                                          ),
                                                                          Text(
                                                                            val.ket ??
                                                                                "",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    IconButton(
                                                                      constraints:
                                                                          const BoxConstraints(),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              4),
                                                                      onPressed:
                                                                          () {
                                                                        Get.to(
                                                                          () =>
                                                                              FormTugasTanggunganPage(
                                                                            id: val.id,
                                                                          ),
                                                                        );
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .edit_document,
                                                                        size:
                                                                            18,
                                                                        color:
                                                                            mainColor,
                                                                      ),
                                                                    ),
                                                                    IconButton(
                                                                      constraints:
                                                                          const BoxConstraints(),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              4),
                                                                      onPressed:
                                                                          () {
                                                                        dialogDelete(val.id ??
                                                                            "");
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        CupertinoIcons
                                                                            .delete,
                                                                        size:
                                                                            18,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          (e.listUploadTugas !=
                                                                      null &&
                                                                  e.listUploadTugas!
                                                                      .isNotEmpty)
                                                              ? const SizedBox(
                                                                  height: 4,
                                                                )
                                                              : const SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                            const SizedBox(
                              height: 40,
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: LogoBanner(),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
