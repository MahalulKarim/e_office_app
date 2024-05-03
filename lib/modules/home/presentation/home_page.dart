import 'package:accordion/accordion.dart';
import 'package:eofficeapp/modules/home/controllers/tugas_panel_controller.dart';
import 'package:eofficeapp/modules/home/controllers/project_controller.dart';
import 'package:eofficeapp/modules/home/presentation/tugas_panel.dart';
import 'package:eofficeapp/modules/logo-banner/logo_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:eofficeapp/common/themes/styles.dart';
import 'package:eofficeapp/modules/materi/presentation/materi_page.dart';
import 'package:eofficeapp/modules/home/controllers/home_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as test;
import 'package:permission_handler/permission_handler.dart';
import 'package:screen_capture_event/screen_capture_event.dart';
import 'package:screen_capture_restrictions/screen_capture_restrictions.dart';
import 'package:screenshot/screenshot.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:media_projection_creator/media_projection_creator.dart';
import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as img;
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'dart:io' show Platform;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScreenshotController screenshotController;
  late HomeController controller;
  late TugasPanelController tugasPanelController;
  late ProjectController projectController;
  String createMediaProjectionResult = 'Unknown';
  Uint8List? screenCapture;

  @override
  void initState() {
    controller = Get.put(HomeController());
    Get.lazyPut(() => TugasPanelController());
    tugasPanelController = Get.find<TugasPanelController>();
    screenshotController = ScreenshotController();
    Get.lazyPut(() => ProjectController());
    projectController = Get.find<ProjectController>();

    super.initState();
  }

  // void _launchContributorApp() async {
  //   const url = 'com.google.android.youtube';
  //   try {
  //     if (await canLaunch(url)) {
  //       await launch(url);
  //     } else {
  //       throw 'Aplikasi tidak ditemukan';
  //     }
  //   } on PlatformException catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: Text('$e'),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }
  void requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  void start() async {
    int errorCode = await MediaProjectionCreator.createMediaProjection();

    setState(() {
      if (errorCode == MediaProjectionCreator.ERROR_CODE_SUCCEED) {
        // Jika pembuatan proyeksi media berhasil, panggil fungsi untuk mengambil tangkapan layar
        // captureAndSendScreenshot();
      } else {
        // Penanganan jika pembuatan proyeksi media gagal
        print('MediaProjection creation failed with error code $errorCode');
      }
    });
  }

  void takeScreenshot() async {
    try {
      final imageFile = await screenshotController.capture();
      if (imageFile != null) {
        // Simpan gambar ke galeri
        final directory = (await getExternalStorageDirectory())!.path;
        final File file = File('$directory/screenshot.png');
        await file.writeAsBytes(imageFile);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Screenshot berhasil disimpan di galeri."),
        ));
      } else {
        throw Exception("Gagal mengambil tangkapan layar: imageFile null");
      }
    } catch (e) {
      print("Gagal mengambil tangkapan layar: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Gagal menyimpan tangkapan layar."),
      ));
    }
  }

  void sendToAPI(String base64Image) {
    // Kirim base64 string ke API, misalnya menggunakan HTTP POST request
    // Pastikan API Anda memiliki endpoint untuk menerima gambar
    // Contoh:
    // http.post('https://example.com/api/screenshot', body: {'image': base64Image});
    print('Disini');
  }

  void finish() async {
    await MediaProjectionCreator.destroyMediaProjection();
    setState(() {
      createMediaProjectionResult = 'Tidak Terdefinisi';
    });
  }

  bool isWorking = false;
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
                      await tugasPanelController.getData();
                      await projectController.getData2();
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
                                ? Shimmer(
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
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  )
                                : Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            controller.userController
                                                    .dataInfoUser.greeting ??
                                                "",
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              fontFamily: 'Inter',
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            height: (controller
                                                        .userController
                                                        .dataInfoUser
                                                        .isMonitor ??
                                                    false)
                                                ? 4
                                                : 0,
                                          ),
                                          (controller.userController
                                                      .dataInfoUser.isMonitor ??
                                                  false)
                                              ? Text(
                                                  controller
                                                          .userController
                                                          .dataInfoUser
                                                          .textStatusWfh ??
                                                      "",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                    fontFamily: 'Inter',
                                                  ),
                                                  textAlign: TextAlign.left,
                                                )
                                              : const SizedBox(),
                                          SizedBox(
                                            height: (controller
                                                        .userController
                                                        .dataInfoUser
                                                        .isMonitor ??
                                                    false)
                                                ? 4
                                                : 0,
                                          ),
                                          (controller.userController
                                                      .dataInfoUser.isMonitor ??
                                                  false)
                                              ? Text(
                                                  controller
                                                          .userController
                                                          .dataInfoUser
                                                          .textTotalJamKerja ??
                                                      "",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                    fontFamily: 'Inter',
                                                  ),
                                                  textAlign: TextAlign.left,
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ],
                                  ),
                            const SizedBox(
                              height: 4,
                            ),
                            // SizedBox(width: 10),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     _launchContributorApp();
                            //   },
                            //   child: Text('open social network'),
                            // ),
                            SizedBox(width: 60),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      40), // Menambahkan jarak horizontal di kedua sisi
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Mengatur tombol agar berada di sebelah kiri dan kanan
                                children: [
                                  // ElevatedButton(
                                  //   onPressed: () async {
                                  //     // Panggil fungsi untuk membuka aplikasi WhatsApp
                                  //     String url =
                                  //         'com.whatsapp'; // URL untuk WhatsApp
                                  //     if (await canLaunch(url)) {
                                  //       await launch(
                                  //           url); // Buka URL dengan package url_launcher
                                  //     } else {
                                  //       // Jika tidak bisa membuka URL, tampilkan pesan kesalahan
                                  //       print('Could not launch $url');
                                  //     }
                                  //   },
                                  //   style: ElevatedButton.styleFrom(
                                  //     primary: Colors
                                  //         .green, // Mengatur warna latar belakang menjadi hijau
                                  //     onPrimary: Colors
                                  //         .white, // Mengatur warna teks menjadi putih
                                  //   ),
                                  //   child: Text('Whatsapp'),
                                  // ),
                                  // ElevatedButton(
                                  //   onPressed: () async {
                                  //     // Panggil fungsi untuk membuka aplikasi WhatsApp
                                  //     String url =
                                  //         'com.diengcyber.tanganangie_eoffice'; // URL untuk WhatsApp
                                  //     if (await canLaunch(url)) {
                                  //       await launch(
                                  //           url); // Buka URL dengan package url_launcher
                                  //     } else {
                                  //       // Jika tidak bisa membuka URL, tampilkan pesan kesalahan
                                  //       print('Could not launch $url');
                                  //     }
                                  //   },
                                  //   style: ElevatedButton.styleFrom(
                                  //     primary: Colors
                                  //         .black, // Mengatur warna latar belakang menjadi hitam
                                  //     onPrimary: Colors
                                  //         .white, // Mengatur warna teks menjadi putih
                                  //   ),
                                  //   child: Text('Instagram'),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(width: 60),

                            ElevatedButton(
                              onPressed: () {
                                // Memeriksa apakah pekerjaan sudah dimulai atau belum
                                if (!isWorking) {
                                  start(); // Memulai pekerjaan jika belum dimulai
                                } else {
                                  finish(); // Mengakhiri pekerjaan jika sudah dimulai
                                }
                                // Mengubah nilai variabel isWorking menjadi kebalikannya (true menjadi false atau sebaliknya)
                                setState(() {
                                  isWorking = !isWorking;
                                });
                              },

                              style: ElevatedButton.styleFrom(
                                primary: isWorking
                                    ? Color.fromARGB(255, 230, 153, 1)
                                    : Color.fromARGB(255, 255, 213,
                                        0), // Warna latar belakang yang berbeda tergantung pada status pekerjaan
                                onPrimary: Colors.white, // Warna teks
                              ),

                              child: Text(isWorking
                                  ? 'Finish Work'
                                  : 'Start Work'), // Mengubah teks tombol sesuai dengan status pekerjaan
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                takeScreenshot();
                              },
                              child: Text('Capture Screen'),
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
                                      const SizedBox(
                                        height: 4,
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
                                            LineIcons.calendarWithWeekFocus,
                                            color: mainColor,
                                          ),
                                        ),
                                        header: Text(
                                          controller.userController.dataInfoUser
                                                  .strTime ??
                                              "",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        content: Column(
                                          children: [
                                            controller.userController
                                                        .textInfo ==
                                                    ''
                                                ? const SizedBox()
                                                : Container(
                                                    width: double.infinity,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 12,
                                                      horizontal: 16,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      color: Colors
                                                          .yellow.shade100,
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Colors
                                                            .yellow.shade200,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .info_outline,
                                                              size: 22,
                                                            ),
                                                            const SizedBox(
                                                                width: 6),
                                                            Text(
                                                              "Informasi",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade800,
                                                                fontFamily:
                                                                    'Inter',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Divider(),
                                                        Text(
                                                          controller
                                                              .userController
                                                              .textInfo,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey.shade800,
                                                            fontFamily: 'Inter',
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            SizedBox(
                                              height: (controller
                                                              .userController
                                                              .dataInfoUser
                                                              .totalTanggungan ??
                                                          0) >
                                                      0
                                                  ? 12
                                                  : 0,
                                            ),
                                            (controller
                                                            .userController
                                                            .dataInfoUser
                                                            .totalTanggungan ??
                                                        0) >
                                                    0
                                                ? Container(
                                                    width: double.infinity,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 12,
                                                      horizontal: 16,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      color: Colors.red,
                                                    ),
                                                    child: const Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Anda punya tanggungan belum selesai!",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily: 'Inter',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
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
                                            LineIcons.book,
                                            color: mainColor,
                                          ),
                                        ),
                                        header: const Text(
                                          'Materi',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed: () => Get.to(
                                                  () => const MateriPage()),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.remove_red_eye,
                                                    color: Colors.blue.shade700,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    'Lihat daftar materi',
                                                    style: TextStyle(
                                                      color:
                                                          Colors.blue.shade600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
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
                                            LineIcons.clipboardWithCheck,
                                            color: mainColor,
                                          ),
                                        ),
                                        header: const Text(
                                          'Tugas',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        content: const TugasPanel(),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: Platform.isIOS ? 20 : 40,
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
