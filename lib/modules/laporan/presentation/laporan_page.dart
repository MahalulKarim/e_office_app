import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eofficeapp/modules/absensi/controllers/absensi_controller.dart';
import 'package:eofficeapp/modules/laporan/controllers/laporan_controller.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({Key? key}) : super(key: key);

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  late LaporanController _laporanController;
  late AbsensiController _absensiController;
  final ImagePicker _picker = ImagePicker();
  XFile? _lampiran;

  bool showDetail = false;
  bool showButton = false;
  bool enableButton = false;

  @override
  void initState() {
    super.initState();
    _laporanController = Get.put(LaporanController());
    _absensiController = Get.find<AbsensiController>();
    getLostData();
  }

  Future<void> getLostData() async {
    final ImagePicker picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    final List<XFile>? files = response.files;
    if (files != null) {
      setState(() {
        _lampiran = files[0];
      });
    }
  }

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
      imageQuality: 60,
    );
    if (image != null) {
      setState(() {
        _lampiran = image;
      });
    }
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        var tugasItem = _laporanController.listTugas
            .map((e) => DropdownMenuItem(
                  value: e.id,
                  child: Text(e.judul!),
                ))
            .toList();
        return SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: CustomScrollView(slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8),
                      child: Row(
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
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: _laporanController.jenis,
                              onChanged: (val) {
                                setState(() {
                                  _laporanController.jenis = val as int;
                                  _laporanController.progress = 0;
                                  _laporanController.waktu = 1;
                                  _laporanController.tugasSelected = "";
                                  _laporanController.judulController.text = "";
                                  _laporanController.deskripsiController.text =
                                      "";
                                  _lampiran = null;
                                  _laporanController
                                      .keteranganTambahController.text = "";
                                  showDetail = false;
                                  showButton = true;
                                  enableButton = false;
                                });
                              },
                            ),
                            const Text("Tugas Belum Selesai"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: _laporanController.jenis,
                              onChanged: (val) {
                                setState(() {
                                  _laporanController.jenis = val as int;
                                  _laporanController.progress = 0;
                                  _laporanController.waktu = 1;
                                  _laporanController.tugasSelected = "";
                                  _laporanController.judulController.text = "";
                                  _laporanController.deskripsiController.text =
                                      "";
                                  _lampiran = null;
                                  _laporanController
                                      .keteranganTambahController.text = "";
                                  showDetail = false;
                                  showButton = true;
                                  enableButton = true;
                                });
                              },
                            ),
                            const Text("Tugas Baru"),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (_laporanController.jenis == 1) ...[
                      const Text(
                        "Pilih Tugas",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      InputDecorator(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: _laporanController.tugasSelected,
                            items: [
                              const DropdownMenuItem(
                                value: '',
                                enabled: false,
                                child: Text('Pilih Tugas'),
                              ),
                              ...tugasItem,
                            ],
                            isDense: true,
                            isExpanded: true,
                            elevation: 0,
                            hint: const Text('Pilih Tugas'),
                            onChanged: (val) {
                              setState(() {
                                _laporanController.tugasSelected =
                                    val as String;
                                showDetail = true;
                                enableButton = true;
                              });
                            },
                          ),
                        ),
                      ),
                      if (showDetail) ...[
                        _lampiran == null
                            ? const SizedBox(
                                height: 16,
                              )
                            : const SizedBox(),
                        _lampiran != null
                            ? GestureDetector(
                                onTap: () {
                                  _showModalImage();
                                },
                                child: Semantics(
                                  child: Image.file(
                                    File(_lampiran!.path),
                                    height:
                                        MediaQuery.of(context).size.height * .2,
                                  ),
                                ),
                              )
                            : TextButton.icon(
                                onPressed: () {
                                  _showModalImage();
                                },
                                icon: const Icon(Icons.photo_filter),
                                label: const Text("FILE LAMPIRAN"),
                              ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Progress",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 25,
                                    groupValue: _laporanController.progress,
                                    onChanged: (val) {
                                      setState(() {
                                        _laporanController.progress =
                                            val as int;
                                      });
                                    }),
                                const Text("25%"),
                                Radio(
                                    value: 50,
                                    groupValue: _laporanController.progress,
                                    onChanged: (val) {
                                      setState(() {
                                        _laporanController.progress =
                                            val as int;
                                      });
                                    }),
                                const Text("50%"),
                                Radio(
                                    value: 75,
                                    groupValue: _laporanController.progress,
                                    onChanged: (val) {
                                      setState(() {
                                        _laporanController.progress =
                                            val as int;
                                      });
                                    }),
                                const Text("75%"),
                                Radio(
                                    value: 100,
                                    groupValue: _laporanController.progress,
                                    onChanged: (val) {
                                      setState(() {
                                        _laporanController.progress =
                                            val as int;
                                      });
                                    }),
                                const Text("100%"),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Keterangan',
                            border: OutlineInputBorder(),
                          ),
                          controller:
                              _laporanController.keteranganTambahController,
                        ),
                        const SizedBox(height: 16),
                        InputDecorator(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: _laporanController.waktu,
                              items: const [
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text("Pekerjaan Pagi"),
                                ),
                                DropdownMenuItem(
                                  value: 2,
                                  child: Text("Pekerjaan Siang"),
                                )
                              ],
                              isDense: true,
                              isExpanded: true,
                              elevation: 0,
                              hint: const Text('Pilih Waktu'),
                              onChanged: (val) {
                                setState(() {
                                  _laporanController.waktu = val as int;
                                });
                              },
                            ),
                          ),
                        ),
                      ]
                    ],
                    if (_laporanController.jenis == 2) ...[
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Judul',
                          border: OutlineInputBorder(),
                        ),
                        controller: _laporanController.judulController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Deskripsi',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: null,
                        controller: _laporanController.deskripsiController,
                        keyboardType: TextInputType.multiline,
                      ),
                      _lampiran == null
                          ? const SizedBox(
                              height: 16,
                            )
                          : const SizedBox(),
                      _lampiran != null
                          ? GestureDetector(
                              onTap: () {
                                _showModalImage();
                              },
                              child: Semantics(
                                child: Image.file(
                                  File(_lampiran!.path),
                                  height:
                                      MediaQuery.of(context).size.height * .2,
                                ),
                              ),
                            )
                          : TextButton.icon(
                              onPressed: () {
                                _showModalImage();
                              },
                              icon: const Icon(Icons.photo_filter),
                              label: const Text("KIRIM LAMPIRAN"),
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Progress",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 25,
                                  groupValue: _laporanController.progress,
                                  onChanged: (val) {
                                    setState(() {
                                      _laporanController.progress = val as int;
                                    });
                                  }),
                              const Text("25%"),
                              Radio(
                                  value: 50,
                                  groupValue: _laporanController.progress,
                                  onChanged: (val) {
                                    setState(() {
                                      _laporanController.progress = val as int;
                                    });
                                  }),
                              const Text("50%"),
                              Radio(
                                  value: 75,
                                  groupValue: _laporanController.progress,
                                  onChanged: (val) {
                                    setState(() {
                                      _laporanController.progress = val as int;
                                    });
                                  }),
                              const Text("75%"),
                              Radio(
                                  value: 100,
                                  groupValue: _laporanController.progress,
                                  onChanged: (val) {
                                    setState(() {
                                      _laporanController.progress = val as int;
                                    });
                                  }),
                              const Text("100%"),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Waktu",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      InputDecorator(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: _laporanController.waktu,
                            items: const [
                              DropdownMenuItem(
                                value: 1,
                                child: Text("Pekerjaan Pagi"),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text("Pekerjaan Siang"),
                              )
                            ],
                            isDense: true,
                            isExpanded: true,
                            elevation: 0,
                            hint: const Text('Pilih Waktu'),
                            onChanged: (val) {
                              setState(() {
                                _laporanController.waktu = val as int;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Keterangan Tambahan',
                          border: OutlineInputBorder(),
                        ),
                        controller:
                            _laporanController.keteranganTambahController,
                      ),
                    ],
                    const SizedBox(
                      height: 24,
                    ),
                    showButton
                        ? ElevatedButton(
                            onPressed: enableButton ? () {} : null,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                            ),
                            child: const Text(
                              "KIRIM LAPORAN",
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        );
      }),
    );
  }
}
