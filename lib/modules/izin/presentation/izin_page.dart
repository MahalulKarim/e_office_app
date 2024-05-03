import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eofficeapp/common/themes/styles.dart';
import 'package:eofficeapp/modules/absensi/controllers/absensi_controller.dart';
import 'package:eofficeapp/modules/izin/controllers/izin_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IzinPage extends StatefulWidget {
  final CameraController cameraController;
  final bool isCameraReady;

  const IzinPage(
      {Key? key, required this.cameraController, required this.isCameraReady})
      : super(key: key);

  @override
  State<IzinPage> createState() => _IzinPageState();
}

class _IzinPageState extends State<IzinPage> {
  final _picker = ImagePicker();
  XFile? _image;

  Future<void> _showModalImage() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (context) {
        return Wrap(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextButton.icon(
                    icon: const Icon(
                      Icons.image_search,
                      color: Colors.blue,
                    ),
                    label: const Text(
                      "Pilih dari galeri",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () async {
                      await _imagePicker(ImageSource.gallery);
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextButton.icon(
                    icon: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                    label: const Text(
                      "Buka Kamera",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () async {
                      await _imagePicker(ImageSource.camera);
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _imagePicker(ImageSource imgSource) async {
    final XFile? image = await _picker.pickImage(
      source: imgSource,
      imageQuality: 50,
    );
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
    Get.back();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final absensiController = Get.find<AbsensiController>();
    final izinController = Get.put(IzinController());
    final refreshController = RefreshController();
    return Scaffold(
      body: SafeArea(
          child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SmartRefresher(
                  controller: refreshController,
                  onRefresh: () async {
                    await absensiController.getKalimat();
                    await absensiController.getPosition();
                    await absensiController.getStatus();
                    refreshController.refreshCompleted();
                  },
                  child: Obx(
                    () => Stack(children: [
                      Positioned.fill(
                        child: CustomScrollView(
                          slivers: [
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: absensiController.status == 2
                                  ? Column(
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
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center),
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
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.amber.shade100,
                                                spreadRadius: 1,
                                                blurRadius: 4,
                                              )
                                            ],
                                          ),
                                          padding: const EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            top: 10,
                                            bottom: 16,
                                          ),
                                          margin: const EdgeInsets.all(16),
                                          child: Column(
                                            children: [
                                              Text(
                                                absensiController.kalimatBijak,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Izin  ${absensiController.status == 0 ? "Tidak Masuk" : "Pulang"}',
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(
                                            labelText: 'Tanggal',
                                            border: OutlineInputBorder(),
                                          ),
                                          readOnly: true,
                                          controller:
                                              izinController.tglController,
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Alasan",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            InputDecorator(
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0)),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.all(10)),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  value: izinController.alasan,
                                                  isDense: true,
                                                  elevation: 0,
                                                  hint: const Text(
                                                      'Pilih Alasan'),
                                                  items: const [
                                                    DropdownMenuItem(
                                                        value: "1",
                                                        child: Text("Izin")),
                                                    DropdownMenuItem(
                                                        value: "2",
                                                        child: Text("Sakit")),
                                                    DropdownMenuItem(
                                                        value: "3",
                                                        child: Text("Alpha")),
                                                  ],
                                                  onChanged: (val) {
                                                    setState(() {
                                                      izinController.alasan =
                                                          val.toString();
                                                    });
                                                  },
                                                  isExpanded: true,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        TextField(
                                          controller: izinController
                                              .keteranganController,
                                          decoration: const InputDecoration(
                                            labelText: 'Keterangan',
                                            border: OutlineInputBorder(),
                                          ),
                                          maxLines: null,
                                          keyboardType: TextInputType.multiline,
                                        ),
                                        _image == null
                                            ? const SizedBox(
                                                height: 16,
                                              )
                                            : const SizedBox(),
                                        _image != null
                                            ? GestureDetector(
                                                onTap: () {
                                                  _showModalImage();
                                                },
                                                child: Semantics(
                                                  child: Image.file(
                                                    File(_image!.path),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .2,
                                                  ),
                                                ),
                                              )
                                            : TextButton.icon(
                                                onPressed: () {
                                                  _showModalImage();
                                                },
                                                icon: const Icon(
                                                    Icons.photo_filter),
                                                label: const Text("SURAT IJIN"),
                                              ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        if (absensiController.status != 0) ...[
                                          _cameraWidget()
                                        ]
                                      ],
                                    ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: absensiController.status == 2
                            ? const SizedBox()
                            : ElevatedButton(
                                onPressed: izinController.isLoading
                                    ? null
                                    : () async {
                                        XFile? image;
                                        if (absensiController.status != 0) {
                                          image = await _takePicture();
                                          if (image == null) {
                                            Get.snackbar(
                                              "ERROR",
                                              "Gagal mengambil foto, mohon berikan perizinan kamera",
                                              snackPosition: SnackPosition.TOP,
                                              backgroundColor: Colors.white,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                              icon: const Icon(Icons.close,
                                                  color: Colors.red),
                                              duration:
                                                  const Duration(seconds: 2),
                                            );
                                            return;
                                          }
                                        }

                                        if (_image == null) {
                                          Get.snackbar(
                                            "ERROR",
                                            "Surat izin tidak boleh kosong",
                                            snackPosition: SnackPosition.TOP,
                                            backgroundColor: Colors.white,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            icon: const Icon(Icons.close,
                                                color: Colors.red),
                                            duration:
                                                const Duration(seconds: 2),
                                          );
                                          return;
                                        }
                                        var res = await izinController.submit(
                                            absensiController.status,
                                            _image!,
                                            image,
                                            absensiController
                                                .locationStatement);
                                        if (res) {
                                          await absensiController.getStatus();
                                          setState(() {
                                            izinController.keteranganController
                                                .clear();
                                            izinController.alasan = "1";
                                            _image = null;
                                          });

                                          Get.snackbar(
                                            "SUCCESS",
                                            "Berhasil izin",
                                            snackPosition: SnackPosition.TOP,
                                            backgroundColor: Colors.white,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            icon: const Icon(Icons.check_circle,
                                                color: Colors.green),
                                            duration:
                                                const Duration(seconds: 2),
                                          );
                                        } else {
                                          //
                                        }
                                      },
                                child: const Text(
                                  "SUBMIT",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                      ),
                    ]),
                  )))),
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
}
