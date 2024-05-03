import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:eofficeapp/common/themes/styles.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/shared/widgets/dont_close_window.dart';
import '../controllers/izin_2_controller.dart';

class Izin2Page extends StatefulWidget {
  const Izin2Page({Key? key}) : super(key: key);

  @override
  Izin2PageState createState() => Izin2PageState();
}

const dataIzin = ["Izin", "Sakit", "Alpha"];

class Izin2PageState extends State<Izin2Page> {
  final formatDate = DateFormat('yyyy-MM-dd');
  final imgPicker = ImagePicker();
  late Izin2Controller izin2controller;
  final refreshController = RefreshController();
  final formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    izin2controller = Get.put(Izin2Controller());
    super.initState();
  }

  dialogChooseCam() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    await imagePickerSuratIzin(ImageSource.gallery);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    width: double.infinity,
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.photo_on_rectangle,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Pilih dari galeri",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    await imagePickerSuratIzin(ImageSource.camera);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    width: double.infinity,
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.photo_camera,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Buka Kamera",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> imagePickerSuratIzin(ImageSource imgSource) async {
    final XFile? image = await imgPicker.pickImage(
      source: imgSource,
      imageQuality: 50,
    );
    if (image != null) {
      izin2controller.imgSuratIzin = image;
    }
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          statusBarColor: mainColor.shade900,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        foregroundColor: mainColor,
        title: const Text("Izin"),
      ),
      body: SafeArea(
        child: Obx(() {
          if (izin2controller.isLoading) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Memproses izin Anda...",
                    style: TextStyle(color: mainColor),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  const DontCloseWindow(),
                ],
              ),
            );
          }
          if (izin2controller.isSuccess) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 70,
                    color: mainColor,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Izin Terkirim",
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Kembali"),
                  ),
                ],
              ),
            );
          }
          return SmartRefresher(
            controller: refreshController,
            onRefresh: () async {
              izin2controller.getPosition();
              refreshController.refreshCompleted();
              refreshController.loadComplete();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (izin2controller.userController.dataInfoUser
                                          .statusTidakMasuk ??
                                      0) >
                                  0 &&
                              (izin2controller.userController.dataInfoUser
                                          .statusTidakMasuk ??
                                      0) <
                                  4
                          ? Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              margin: const EdgeInsets.only(
                                bottom: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.yellow.shade50,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.yellow.shade200,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Anda sudah izin hari ini!",
                                    style:
                                        TextStyle(color: Colors.grey.shade800),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(6),
                        color: Colors.grey,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          child: SizedBox(
                            height: 30,
                            child: Center(
                              child: izin2controller.gpsController.loading
                                  ? const Text(
                                      "Mendapatkan lokasi...",
                                      style: TextStyle(color: Colors.black),
                                    )
                                  : Text(
                                      "Lokasi: ${izin2controller.locationStatement}",
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FormBuilderDateTimePicker(
                        name: 'tanggal',
                        initialEntryMode: DatePickerEntryMode.calendar,
                        initialValue: DateTime.now(),
                        inputType: InputType.date,
                        format: formatDate,
                        decoration: InputDecoration(
                          labelText: 'Tanggal Izin',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 12,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(height: 12),
                      FormBuilderDropdown<String>(
                        name: 'alasan',
                        decoration: InputDecoration(
                          labelText: 'Alasan',
                          hintText: 'Pilih Alasan',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 12,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        items: dataIzin
                            .map((a) => DropdownMenuItem(
                                  value: (dataIzin.indexOf(a) + 1).toString(),
                                  child: Text(a),
                                ))
                            .toList(),
                        onChanged: (val) {},
                        valueTransformer: (val) => val?.toString(),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          dialogChooseCam();
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(6),
                          color: izin2controller.imgSuratIzin.path != ""
                              ? mainColor
                              : Colors.grey.shade400,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            child: izin2controller.imgSuratIzin.path != ""
                                ? Container(
                                    width: double.infinity,
                                    constraints:
                                        const BoxConstraints(maxHeight: 400),
                                    child: Image.file(
                                      File(izin2controller.imgSuratIzin.path),
                                      width: double.infinity,
                                    ),
                                  )
                                : Container(
                                    height: 125,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.mail),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "SURAT IZIN",
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () async {
                          final XFile? image = await imgPicker.pickImage(
                            source: ImageSource.camera,
                            imageQuality: 50,
                          );
                          if (image != null) {
                            izin2controller.imgFoto = image;
                          }
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(6),
                          color: Colors.grey.shade400,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            child: izin2controller.imgFoto.path != ""
                                ? Container(
                                    width: double.infinity,
                                    constraints:
                                        const BoxConstraints(maxHeight: 400),
                                    child: Image.file(
                                      File(izin2controller.imgFoto.path),
                                      width: double.infinity,
                                    ),
                                  )
                                : Container(
                                    height: 125,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.co_present),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "FOTO",
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      FormBuilderTextField(
                        name: 'keterangan',
                        decoration: InputDecoration(
                          labelText: 'Keterangan',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 12,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.top,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (izin2controller.imgSuratIzin.path == "") {
                              Get.snackbar(
                                "Invalid",
                                "Surat Izin harus ada!",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.white,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                icon: const Icon(
                                  Icons.warning_rounded,
                                  color: Colors.red,
                                ),
                                duration: const Duration(seconds: 2),
                              );
                              return;
                            }
                            if (izin2controller.imgFoto.path == "") {
                              Get.snackbar(
                                "Invalid",
                                "Foto harus ada!",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.white,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                icon: const Icon(
                                  Icons.warning_rounded,
                                  color: Colors.red,
                                ),
                                duration: const Duration(seconds: 2),
                              );
                              return;
                            }
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              final response = await izin2controller
                                  .submitIzin(formKey.currentState!.value);
                              if (response) {
                                formKey.currentState!.reset();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(40, 50),
                            backgroundColor: mainColor.shade900,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("SUBMIT IZIN"),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
