import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:eofficeapp/common/themes/styles.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../../common/shared/widgets/dont_close_window.dart';
import '../controllers/absensi_2_controller.dart';
import 'absensi_message_page.dart';

import 'media_size_clipper.dart';

class Absensi2Page extends StatefulWidget {
  const Absensi2Page({
    Key? key,
    required this.statPresensi,
  }) : super(key: key);

  final int statPresensi;

  @override
  State<Absensi2Page> createState() => _Absensi2PageState();
}

class _Absensi2PageState extends State<Absensi2Page> {
  late CameraController cameraController;
  late Absensi2Controller absensi2controller;
  final refreshController = RefreshController();

  @override
  void initState() {
    absensi2controller = Get.put(Absensi2Controller());
    initCamera();
    super.initState();
  }

  void initCamera() async {
    absensi2controller.isCameraIsInitialized = false;
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      print("Tidak ada kamera");
      Get.back();
      return;
    }
    CameraDescription firstCamera;
    if (kIsWeb) {
      firstCamera = cameras[0];
    } else {
      firstCamera = cameras[1];
    }
    cameraController = CameraController(
      firstCamera,
      ResolutionPreset.low,
      enableAudio: false,
    );
    cameraController.initialize().then((_) {
      absensi2controller.isCameraIsInitialized = true;
      absensi2controller.isCameraError = false;
      if (!mounted) {
        return;
      }
    }).catchError((Object e) {
      absensi2controller.isCameraIsInitialized = false;
      absensi2controller.isCameraError = true;
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            absensi2controller.cameraErrorMsg =
                "Gagal menginisiasi kamera, mohon berikan perizinan kamera";
            break;
          case 'CameraAccessRestricted':
            absensi2controller.cameraErrorMsg =
                "Gagal menginisiasi kamera, mohon berikan perizinan kamera";
            break;
          default:
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy kk:mm:ss').format(dateTime);
  }

  Future<void> processMasuk({bool withConfirmable = true}) async {
    if (withConfirmable) {
      if (!absensi2controller.isOfficePosition) {
        dialogConfirmLocationNotOffice(onOk: () async {
          await processMasuk(withConfirmable: false);
        });
        return;
      }
    }
    final response = await absensi2controller.submitMasuk(cameraController);
    if (response.status == "ok") {
      if (response.data!.late == true) {
        Get.to(
          () => AbsensiMessagePage(
            status: 'danger',
            msg: 'Berhasil absen masuk!',
            ket: response.data!.info,
          ),
        );
      } else {
        Get.to(
          () => const AbsensiMessagePage(
            status: 'success',
            msg: 'Berhasil absen masuk!',
            ket: '(Tepat waktu)',
          ),
        );
      }
    }
  }

  Future<void> processPulang({bool withConfirmable = true}) async {
    if (withConfirmable) {
      if (!absensi2controller.isOfficePosition) {
        dialogConfirmLocationNotOffice(onOk: () async {
          await processPulang(withConfirmable: false);
        });
        return;
      }
    }
    final response = await absensi2controller.submitPulang(cameraController);
    if (response) {
      Get.to(
        () => const AbsensiMessagePage(
          status: 'success',
          msg: 'Berhasil absen pulang!',
          ket: 'Terimakasih dan Sampai bertemu kembali!',
          showStatusIn: false,
        ),
      );
    }
  }

  dialogConfirmLocationNotOffice({required Function onOk}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi"),
          content: Text(
            "Lokasi anda tidak di Area Kantor / WFH, tetap lanjutkan?",
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "Batal",
                style: TextStyle(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Get.back();
                await Future.delayed(const Duration(milliseconds: 700),
                    () async {
                  onOk();
                });
              },
              child: const Text("Iya, simpan lokasi"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () {
          if (!absensi2controller.isCameraIsInitialized) {
            return const SafeArea(
              child: Center(
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            );
          }
          if (absensi2controller.loadingSubmit) {
            return SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    CircularProgressIndicator(
                      color: mainColor,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Memproses presensi Anda...",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    const DontCloseWindow(),
                  ],
                ),
              ),
            );
          }

          final mediaSize = MediaQuery.of(context).size;
          final scale =
              1 / (cameraController.value.aspectRatio * mediaSize.aspectRatio);

          return SafeArea(
            child: absensi2controller.isCameraError
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        absensi2controller.cameraErrorMsg,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          cameraController.dispose();
                          initCamera();
                        },
                        child: const Text("Buka Akses Kamera"),
                      ),
                    ],
                  )
                : SmartRefresher(
                    controller: refreshController,
                    onRefresh: () async {
                      absensi2controller.getPosition();
                      refreshController.refreshCompleted();
                      refreshController.loadComplete();
                    },
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          ClipRect(
                            clipper: MediaSizeClipper(mediaSize),
                            child: Transform.scale(
                              scale: scale,
                              alignment: Alignment.topCenter,
                              child: CameraPreview(cameraController),
                            ),
                          ),
                          Positioned(
                            top: 6,
                            left: 6,
                            child: Row(
                              children: [
                                SizedBox(
                                  child: Image.asset(
                                    'assets/img_logo.png',
                                    height: 100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 0,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "PRESENSI ${widget.statPresensi == 1 ? "MASUK" : "PULANG"} ${absensi2controller.userController.dataInfoUser.isWfh == 1 ? "WFH" : ""}",
                                            style: TextStyle(
                                              color: mainColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              StreamBuilder(
                                                stream: Stream.periodic(
                                                    const Duration(seconds: 1)),
                                                builder: (context, snapshot) {
                                                  return Text(
                                                    formatDateTime(
                                                        DateTime.now()),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: absensi2controller
                                                    .gpsController.loading
                                                ? const Text(
                                                    "LOKASI: ...",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : Text(
                                                    "LOKASI: ${absensi2controller.locationStatement}",
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                          ),
                                          widget.statPresensi == 1
                                              ? const SizedBox(
                                                  height: 4,
                                                )
                                              : const SizedBox(),
                                          widget.statPresensi == 2
                                              ? Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 8,
                                                    horizontal: 12,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              "Tugas pagi",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            (absensi2controller
                                                                            .userController
                                                                            .dataInfoUser
                                                                            .totalTugasPagi ??
                                                                        0) >
                                                                    0
                                                                ? Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            3),
                                                                    height: 20,
                                                                    width: 20,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color:
                                                                          mainColor,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        ((absensi2controller.userController.dataInfoUser.totalTugasPagi ?? 0) > 9
                                                                                ? "9+"
                                                                                : absensi2controller.userController.dataInfoUser.totalTugasPagi)
                                                                            .toString(),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : const Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              "Tugas Siang",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            (absensi2controller
                                                                            .userController
                                                                            .dataInfoUser
                                                                            .totalTugasSiang ??
                                                                        0) >
                                                                    0
                                                                ? Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            3),
                                                                    height: 20,
                                                                    width: 20,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color:
                                                                          mainColor,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        ((absensi2controller.userController.dataInfoUser.totalTugasSiang ?? 0) > 9
                                                                                ? "9+"
                                                                                : absensi2controller.userController.dataInfoUser.totalTugasSiang)
                                                                            .toString(),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : const Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: absensi2controller
                                                    .gpsController.loading
                                                ? null
                                                : () {
                                                    absensi2controller
                                                        .getPosition();
                                                  },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              minimumSize: const Size(40, 55),
                                              backgroundColor:
                                                  mainColor.shade800,
                                            ),
                                            child: Icon(
                                              absensi2controller
                                                          .locationStatement ==
                                                      "Tidak dapat mengetahui Lokasi"
                                                  ? Icons.location_off
                                                  : Icons.location_on,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Expanded(
                                            child: widget.statPresensi == 1
                                                ? ElevatedButton(
                                                    onPressed: absensi2controller
                                                                .isOfficePosition ||
                                                            (absensi2controller
                                                                        .userController
                                                                        .dataInfoUser
                                                                        .isWfh ==
                                                                    1 &&
                                                                absensi2controller
                                                                        .locationStatement !=
                                                                    "Tidak dapat mengetahui Lokasi") ||
                                                            (absensi2controller
                                                                        .userController
                                                                        .dataInfoUser
                                                                        .wfh ==
                                                                    1 &&
                                                                absensi2controller
                                                                        .locationStatement !=
                                                                    "Tidak dapat mengetahui Lokasi")
                                                        ? () async {
                                                            await processMasuk();
                                                          }
                                                        : null,
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      elevation: 0,
                                                      backgroundColor:
                                                          mainColor.shade900,
                                                      minimumSize:
                                                          const Size(40, 55),
                                                    ),
                                                    child: Text(
                                                      "MASUK${absensi2controller.userController.dataInfoUser.isWfh == 1 ? " WFH" : ""}",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  )
                                                : ElevatedButton(
                                                    onPressed: absensi2controller
                                                                .isOfficePosition ||
                                                            (absensi2controller
                                                                        .userController
                                                                        .dataInfoUser
                                                                        .isWfh ==
                                                                    1 &&
                                                                absensi2controller
                                                                        .locationStatement !=
                                                                    "Tidak dapat mengetahui Lokasi") ||
                                                            (absensi2controller
                                                                        .userController
                                                                        .dataInfoUser
                                                                        .wfh ==
                                                                    1 &&
                                                                absensi2controller
                                                                        .locationStatement !=
                                                                    "Tidak dapat mengetahui Lokasi")
                                                        ? () async {
                                                            await processPulang();
                                                          }
                                                        : null,
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.red,
                                                      elevation: 0,
                                                      minimumSize:
                                                          const Size(40, 55),
                                                    ),
                                                    child: Text(
                                                      "PULANG${absensi2controller.userController.dataInfoUser.isWfh == 1 ? " WFH" : ""}",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // absensi2controller
                          //                 .userController.dataInfoUser.isWfh ==
                          //             0 &&
                          //         !absensi2controller.isOfficePosition &&
                          //         !absensi2controller.gpsController.loading
                          //     ? absensi2controller.userController.dataInfoUser
                          //                 .infoFalseGps !=
                          //             ""
                          //         ? Positioned.fill(
                          //             child: Align(
                          //               alignment: Alignment.center,
                          //               child: Container(
                          //                 decoration: BoxDecoration(
                          //                   color: Colors.black,
                          //                   borderRadius:
                          //                       BorderRadius.circular(10),
                          //                 ),
                          //                 padding: const EdgeInsets.symmetric(
                          //                   vertical: 12,
                          //                   horizontal: 16,
                          //                 ),
                          //                 child: Text(

                          //                   absensi2controller
                          //                           .userController
                          //                           .dataInfoUser
                          //                           .infoFalseGps ??
                          //                       "",
                          //                   textAlign: TextAlign.center,
                          //                   style: const TextStyle(
                          //                       color: Color.fromARGB(255, 248, 233, 231)),
                          //                 ),
                          //               ),
                          //             ),
                          //           )
                          //         : const SizedBox()
                          //     : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
