import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/shared/widgets/dont_close_window.dart';
import '../../../common/themes/styles.dart';
import '../controllers/form_tugas_tanggungan_controller.dart';

class FormTugasTanggunganPage extends StatefulWidget {
  const FormTugasTanggunganPage({
    Key? key,
    this.id,
    this.idTugas,
  }) : super(key: key);

  final String? id;
  final String? idTugas;

  @override
  FormTugasTanggunganPageState createState() => FormTugasTanggunganPageState();
}

class FormTugasTanggunganPageState extends State<FormTugasTanggunganPage> {
  late FormTugasTanggunganController tugasExistingController;
  final refreshController = RefreshController();
  final imgPicker = ImagePicker();

  @override
  void initState() {
    tugasExistingController = Get.put(FormTugasTanggunganController(
      id: widget.id,
      idTugas: widget.idTugas,
    ));
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
                    await imagePickerLampiran(ImageSource.gallery);
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
                    await imagePickerLampiran(ImageSource.camera);
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

  Future<void> imagePickerLampiran(ImageSource imgSource) async {
    final XFile? image = await imgPicker.pickImage(
      source: imgSource,
      imageQuality: 50,
    );
    if (image != null) {
      tugasExistingController.fileLampiran = image;
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
        title: const Text("Tugas tanggungan"),
      ),
      body: SafeArea(
        child: Obx(() {
          if (tugasExistingController.isLoading) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Memuat tugas Anda...",
                    style: TextStyle(color: mainColor),
                  ),
                ],
              ),
            );
          }
          if (tugasExistingController.isLoadingSubmit) {
            return const SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Mengunggah tugas Anda...",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  DontCloseWindow(),
                ],
              ),
            );
          }
          if (tugasExistingController.isSuccess) {
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
                    (widget.id == null || widget.id == '')
                        ? "Tugas berhasil diupload"
                        : "Tugas berhasil di ubah",
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
              tugasExistingController.getTanggungan();
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
                  key: tugasExistingController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormBuilderDropdown<String>(
                        name: 'id',
                        enabled: (widget.id == null || widget.id == ''),
                        decoration: InputDecoration(
                          labelText: 'Pilih Tugas',
                          hintText: 'Pilih Tugas',
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
                        items: tugasExistingController.listTugas
                            .map((a) => DropdownMenuItem(
                                  value: a.id,
                                  child: Text(a.judul ?? ""),
                                ))
                            .toList(),
                        onChanged: (val) {
                          tugasExistingController.infoTugas = "";
                          if (val == null) {
                            return;
                          }
                          var tugasOne = tugasExistingController.listTugas
                              .firstWhere((element) => element.id == val);
                          if (tugasOne.id == null) {
                            return;
                          }
                          tugasExistingController.infoTugas =
                              tugasOne.tugas ?? "";
                        },
                        valueTransformer: (val) => val?.toString(),
                      ),
                      tugasExistingController.infoTugas == ""
                          ? const SizedBox()
                          : Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Tugas",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Html(
                                    data: tugasExistingController.infoTugas,
                                  ),
                                ],
                              ),
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
                          color: tugasExistingController.fileLampiran.path != ""
                              ? mainColor
                              : Colors.grey.shade400,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            child: tugasExistingController.fileLampiran.path !=
                                    ""
                                ? Container(
                                    width: double.infinity,
                                    constraints: const BoxConstraints(
                                      maxHeight: 400,
                                    ),
                                    child: Image.file(
                                      File(tugasExistingController
                                          .fileLampiran.path),
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : tugasExistingController.urlEditFile != ''
                                    ? Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            constraints: const BoxConstraints(
                                              maxHeight: 400,
                                            ),
                                            child: Image.network(
                                              tugasExistingController
                                                  .urlEditFile,
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                color: Colors.white54,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 6,
                                                  horizontal: 12,
                                                ),
                                                child: const Text(
                                                  "SENTUH UNTUK OPSI",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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
                                              Icon(Icons.file_copy_rounded),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                "LAMPIRKAN FILE",
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
                          labelText: 'Link Google Drive',
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
                      const SizedBox(height: 21),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(40, 50),
                            backgroundColor:
                                widget.id != null && widget.id != ""
                                    ? Colors.amber
                                    : Colors.blueGrey,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            if ((widget.id == null || widget.id == '') &&
                                tugasExistingController.fileLampiran.path ==
                                    "") {
                              Get.snackbar(
                                "Invalid",
                                "File lampiran harus ada!",
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
                            if (tugasExistingController.formKey.currentState!
                                .validate()) {
                              tugasExistingController.formKey.currentState!
                                  .save();
                              await tugasExistingController.save(
                                tugasExistingController
                                    .formKey.currentState!.value,
                              );
                              tugasExistingController.formKey.currentState!
                                  .reset();
                            }
                          },
                          child: Text(
                            widget.id != null && widget.id != ""
                                ? "SIMPAN EDIT"
                                : "KIRIM ULANG",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
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
