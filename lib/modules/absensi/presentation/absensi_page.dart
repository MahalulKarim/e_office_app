import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:eofficeapp/common/themes/styles.dart';
import 'package:eofficeapp/modules/absensi/controllers/absensi_controller.dart';
import 'package:eofficeapp/modules/absensi/presentation/absensi_message_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:eofficeapp/modules/histori_absensi/presentation/histori_absensi_page.dart';

class AbsensiPage extends StatefulWidget {
  final CameraController cameraController;
  final bool isCameraReady;

  const AbsensiPage(
      {Key? key, required this.cameraController, required this.isCameraReady})
      : super(key: key);

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  final _absensiController = Get.put(AbsensiController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return absensiScaffold();
  }

  Widget absensiScaffold() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: widget.isCameraReady
              ? Obx(
                  () => Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: SmartRefresher(
                      controller: _absensiController.refreshController,
                      onRefresh: () async {
                        await _absensiController.getKalimat();
                        await _absensiController.getPosition();
                        await _absensiController.getInfo();
                        await _absensiController.getStatus();
                        _absensiController.refreshController.refreshCompleted();
                        _absensiController.refreshController.loadComplete();
                      },
                      child: CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6, bottom: 6, top: 6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.to(
                                                  () => const HistoriAbsensi());
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor:
                                                  Colors.grey.shade100,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                              padding: const EdgeInsets.only(
                                                right: 12,
                                                left: 12,
                                                top: 0,
                                                bottom: 0,
                                              ),
                                              textStyle: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: mainColor,
                                              ),
                                            ),
                                            child: Text(
                                              'Histori Absensi',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: mainColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: _absensiController.status == 0
                                      ? _absenMasuk()
                                      : _absensiController.status != 2
                                          ? _absenKeluar()
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.check_circle,
                                                  color: mainColor.shade800,
                                                  size: 100,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Text(
                                                    "Terima Kasih telah hadir hari ini,",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign:
                                                        TextAlign.center),
                                                const Text(
                                                  "sampai jumpa besok dan semoga selamat sampai tujuan!",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.amber.shade50,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors
                                                            .amber.shade100,
                                                        spreadRadius: 1,
                                                        blurRadius: 4,
                                                      )
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    top: 10,
                                                    bottom: 16,
                                                  ),
                                                  margin:
                                                      const EdgeInsets.all(16),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        _absensiController
                                                            .kalimatBijak,
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Container()),
    );
  }

  Widget _absenMasuk() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
        left: 2,
        right: 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "PRESENSI MASUK",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Waktu", style: TextStyle(fontSize: 18)),
              StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return Text(
                      _formatDateTime(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Lokasi",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                _absensiController.locationStatement,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Kamera",
                style: TextStyle(fontSize: 18),
              ),
              _cameraWidget()
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Sholat Dhuha (bagi Muslim)",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: _absensiController.isDhuha,
                      onChanged: (val) {
                        setState(() {
                          _absensiController.isDhuha = val as int;
                        });
                      }),
                  const Text("Sudah"),
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: _absensiController.isDhuha,
                      onChanged: (val) {
                        setState(() {
                          _absensiController.isDhuha = val as int;
                        });
                      }),
                  const Text("Belum"),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 165, 244, 252),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              _absensiController.info,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _absensiController.isSubmit
                  ? null
                  : () async {
                      var image = await _takePicture();
                      if (image == null) {
                        Get.snackbar(
                          "ERROR",
                          "Gagal mengambil foto, mohon berikan perizinan kamera",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.white,
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          icon: const Icon(Icons.close, color: Colors.red),
                          duration: const Duration(seconds: 2),
                        );
                        return;
                      }
                      var result = await _absensiController.absenMasuk(image);

                      if (!result) {
                        Get.snackbar(
                          "ERROR",
                          "Gagal absen masuk!",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.white,
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          icon: const Icon(Icons.close, color: Colors.red),
                          duration: const Duration(seconds: 2),
                        );
                      } else {
                        await _absensiController.getStatus();
                        Get.to(
                          () => const AbsensiMessagePage(
                            status: 'success',
                            msg: 'Berhasil absen masuk!',
                            ket: '(Tepat waktu)',
                          ),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: const TextStyle(fontSize: 18)),
              child: const Text("LANJUTKAN PRESENSI"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _absenKeluar() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
        left: 2,
        right: 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "PRESENSI PULANG",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Waktu", style: TextStyle(fontSize: 18)),
              StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return Text(
                      _formatDateTime(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Lokasi",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                _absensiController.locationStatement,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Kamera",
                style: TextStyle(fontSize: 18),
              ),
              _cameraWidget()
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _absensiController.statusTugas == 0
                  ? const Icon(
                      Icons.close,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
              const Text(
                "Tugas Pagi",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                width: 10,
              ),
              _absensiController.statusTugas != 2
                  ? const Icon(
                      Icons.close,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
              const Text(
                "Tugas Siang",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 8, right: 8),
            height: 100,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 165, 244, 252),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              _absensiController.info,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _absensiController.isSubmit
                  ? null
                  : () async {
                      var image = await _takePicture();
                      if (image == null) {
                        Get.snackbar(
                          "ERROR",
                          "Gagal mengambil foto, mohon berikan perizinan kamera",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.white,
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          icon: const Icon(Icons.close, color: Colors.red),
                          duration: const Duration(seconds: 2),
                        );
                        return;
                      }
                      var result = await _absensiController.absenKeluar(image);

                      if (!result) {
                        //
                      } else {
                        await _absensiController.getStatus();
                        Get.to(
                          () => const AbsensiMessagePage(
                            status: 'success',
                            msg: 'Berhasil absen pulang!',
                            ket: 'Terimakasih dan Sampai bertemu kembali!',
                          ),
                        );
                        // Get.snackbar(
                        //   "SUCCESS",
                        //   "Berhasil absen pulang!",
                        //   snackPosition: SnackPosition.TOP,
                        //   backgroundColor: Colors.white,
                        //   margin: const EdgeInsets.symmetric(
                        //       vertical: 12, horizontal: 16),
                        //   icon: const Icon(Icons.check_circle,
                        //       color: Colors.green),
                        //   duration: const Duration(seconds: 2),
                        // );
                      }
                    },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: const TextStyle(fontSize: 18)),
              child: const Text("LANJUTKAN PRESENSI"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cameraWidget() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: CameraPreview(widget.cameraController),
    );
  }

  Future<XFile?> _takePicture() async {
    try {
      final image = await widget.cameraController.takePicture();
      return image;
    } on CameraException {
      return null;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy hh:mm:ss').format(dateTime);
  }
}
