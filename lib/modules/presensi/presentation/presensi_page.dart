import 'package:accordion/accordion.dart';
import 'package:eofficeapp/modules/logo-banner/logo_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:eofficeapp/modules/absensi/presentation/absensi_2_page.dart';
import 'package:eofficeapp/modules/auth/controllers/auth_controller.dart';
import 'package:eofficeapp/modules/histori_absensi/presentation/histori_absensi_page.dart';
import 'package:eofficeapp/modules/izin_wfh/presentation/izin_wfh_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:eofficeapp/modules/presensi/controllers/presensi_controller.dart';

import '../../../common/themes/styles.dart';
import '../../izin/presentation/izin_2_page.dart';

class PresensiPage extends StatefulWidget {
  const PresensiPage({Key? key}) : super(key: key);

  @override
  State<PresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  late PresensiController controller;
  late AuthController authController;

  @override
  void initState() {
    controller = Get.put(PresensiController());
    Get.lazyPut(() => AuthController());
    authController = Get.find<AuthController>();
    super.initState();
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
                                            LineIcons.fingerprint,
                                            color: mainColor,
                                          ),
                                        ),
                                        header: const Text(
                                          'Presensi / Kehadiran',
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
                                                  if (controller
                                                          .userController
                                                          .dataInfoUser
                                                          .status ==
                                                      1) {
                                                    Get.snackbar(
                                                      "Presensi",
                                                      "Anda sudah masuk hari ini",
                                                      snackPosition:
                                                          SnackPosition.TOP,
                                                      backgroundColor:
                                                          Colors.white,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12,
                                                          horizontal: 16),
                                                      icon: const Icon(
                                                        Icons.warning_amber,
                                                        color: Colors.amber,
                                                      ),
                                                      duration: const Duration(
                                                          seconds: 2),
                                                    );
                                                    return;
                                                  }
                                                  if (controller
                                                          .userController
                                                          .dataInfoUser
                                                          .status ==
                                                      2) {
                                                    Get.snackbar(
                                                      "Presensi",
                                                      "Anda sudah melakukan presensi hari ini",
                                                      snackPosition:
                                                          SnackPosition.TOP,
                                                      backgroundColor:
                                                          Colors.white,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12,
                                                          horizontal: 16),
                                                      icon: const Icon(
                                                        Icons.warning_amber,
                                                        color: Colors.amber,
                                                      ),
                                                      duration: const Duration(
                                                          seconds: 2),
                                                    );
                                                    return;
                                                  }
                                                  if ((controller
                                                                  .userController
                                                                  .dataInfoUser
                                                                  .statusTidakMasuk ??
                                                              0) >
                                                          0 &&
                                                      (controller
                                                                  .userController
                                                                  .dataInfoUser
                                                                  .statusTidakMasuk ??
                                                              0) <
                                                          4) {
                                                    Get.snackbar(
                                                      "Presensi",
                                                      "Anda melakukan izin di hari ini",
                                                      snackPosition:
                                                          SnackPosition.TOP,
                                                      backgroundColor:
                                                          Colors.white,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12,
                                                          horizontal: 16),
                                                      icon: const Icon(
                                                        Icons.warning_amber,
                                                        color: Colors.amber,
                                                      ),
                                                      duration: const Duration(
                                                          seconds: 2),
                                                    );
                                                    return;
                                                  }
                                                  Get.to(
                                                    () => const Absensi2Page(
                                                      statPresensi: 1,
                                                    ),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.emoji_people_outlined,
                                                  color: Colors.blue.shade600,
                                                ),
                                                label: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "Masuk",
                                                      style: TextStyle(
                                                        color: Colors
                                                            .brown.shade700,
                                                      ),
                                                    ),
                                                    controller
                                                                    .userController
                                                                    .dataInfoUser
                                                                    .status ==
                                                                1 ||
                                                            controller
                                                                    .userController
                                                                    .dataInfoUser
                                                                    .status ==
                                                                2
                                                        ? const Icon(
                                                            Icons.check_circle,
                                                            color: Colors.green,
                                                            size: 19,
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                ),
                                              ),
                                              TextButton.icon(
                                                onPressed: () {
                                                  if (controller
                                                          .userController
                                                          .dataInfoUser
                                                          .status ==
                                                      2) {
                                                    Get.snackbar(
                                                      "Presensi",
                                                      "Anda sudah melakukan presensi hari ini",
                                                      snackPosition:
                                                          SnackPosition.TOP,
                                                      backgroundColor:
                                                          Colors.white,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12,
                                                          horizontal: 16),
                                                      icon: const Icon(
                                                        Icons.warning_amber,
                                                        color: Colors.amber,
                                                      ),
                                                      duration: const Duration(
                                                          seconds: 2),
                                                    );
                                                    return;
                                                  }
                                                  if (controller
                                                          .userController
                                                          .dataInfoUser
                                                          .status !=
                                                      1) {
                                                    Get.snackbar(
                                                      "Presensi",
                                                      "Anda belum masuk hari ini",
                                                      snackPosition:
                                                          SnackPosition.TOP,
                                                      backgroundColor:
                                                          Colors.white,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12,
                                                          horizontal: 16),
                                                      icon: const Icon(
                                                        Icons.warning_amber,
                                                        color: Colors.red,
                                                      ),
                                                      duration: const Duration(
                                                          seconds: 2),
                                                    );
                                                    return;
                                                  }
                                                  if ((controller
                                                                  .userController
                                                                  .dataInfoUser
                                                                  .statusTidakMasuk ??
                                                              0) >
                                                          0 &&
                                                      (controller
                                                                  .userController
                                                                  .dataInfoUser
                                                                  .statusTidakMasuk ??
                                                              0) <
                                                          4) {
                                                    Get.snackbar(
                                                      "Presensi",
                                                      "Anda melakukan izin di hari ini",
                                                      snackPosition:
                                                          SnackPosition.TOP,
                                                      backgroundColor:
                                                          Colors.white,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12,
                                                          horizontal: 16),
                                                      icon: const Icon(
                                                        Icons.warning_amber,
                                                        color: Colors.amber,
                                                      ),
                                                      duration: const Duration(
                                                          seconds: 2),
                                                    );
                                                    return;
                                                  }
                                                  Get.to(
                                                    () => const Absensi2Page(
                                                      statPresensi: 2,
                                                    ),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.home,
                                                  color: Colors.blue.shade600,
                                                ),
                                                label: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "Pulang",
                                                      style: TextStyle(
                                                        color: Colors
                                                            .brown.shade700,
                                                      ),
                                                    ),
                                                    controller
                                                                .userController
                                                                .dataInfoUser
                                                                .status ==
                                                            2
                                                        ? const Icon(
                                                            Icons.check_circle,
                                                            color: Colors.green,
                                                            size: 19,
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                ),
                                              ),
                                              TextButton.icon(
                                                onPressed: () {
                                                  Get.to(() =>
                                                      const HistoriAbsensi());
                                                },
                                                icon: Icon(
                                                  Icons.history_edu_rounded,
                                                  color: Colors.blue.shade600,
                                                ),
                                                label: Text(
                                                  "Riwayat",
                                                  style: TextStyle(
                                                    color: Colors.blue.shade700,
                                                  ),
                                                ),
                                              ),
                                              TextButton.icon(
                                                onPressed: () {
                                                  Get.to(
                                                      () => const Izin2Page());
                                                },
                                                icon: Icon(
                                                  Icons.mail_outline_outlined,
                                                  color: Colors.blue.shade600,
                                                ),
                                                label: Text(
                                                  "Izin tidak masuk",
                                                  style: TextStyle(
                                                    color: Colors.blue.shade700,
                                                  ),
                                                ),
                                              ),
                                              controller.userController
                                                          .dataInfoUser.wfh ==
                                                      1
                                                  ? const SizedBox()
                                                  : TextButton.icon(
                                                      onPressed: () {
                                                        Get.to(
                                                          () =>
                                                              const IzinWfhPage(),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .home_work_outlined,
                                                        color: Colors
                                                            .brown.shade600,
                                                      ),
                                                      label: Text(
                                                        "Permohonan WFH",
                                                        style: TextStyle(
                                                          color: Colors
                                                              .brown.shade700,
                                                        ),
                                                      ),
                                                    ),
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
