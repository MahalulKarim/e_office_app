import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/shared/widgets/dont_close_window.dart';
import '../../../common/themes/styles.dart';
import '../controllers/form_tugas_controller.dart';

class FormTugasPage extends StatefulWidget {
  const FormTugasPage({
    Key? key,
    this.id,
    required this.waktuTugas,
  })  : assert(waktuTugas >= 1 && waktuTugas <= 2),
        super(key: key);

  final String? id;
  final int waktuTugas;

  @override
  FormTugasPageState createState() => FormTugasPageState();
}

class FormTugasPageState extends State<FormTugasPage> {
  late FormTugasController tugasController;
  final imgPicker = ImagePicker();
  final formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    tugasController = Get.put(FormTugasController());
    if (widget.id != null) {
      tugasController.getData(widget.id.toString(), formKey);
    }
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
      tugasController.fileLampiran = image;
    }
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      title: Text((widget.id != null ? "Edit tugas" : "Tugas") +
          (widget.waktuTugas == 2 ? " siang" : " pagi")),
      elevation: 0,
    );
    var heightTop = MediaQuery.of(context).viewPadding.top;

    return SizedBox(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              width: double.infinity,
              height: appBar.preferredSize.height + heightTop,
              decoration: BoxDecoration(
                color: widget.waktuTugas == 2
                    ? Colors.amber.shade600
                    : Colors.blue,
                image: DecorationImage(
                  image: widget.waktuTugas == 2
                      ? const AssetImage('assets/grad3.png')
                      : const AssetImage('assets/grad4.png'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                  ),
                ],
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar,
            body: SafeArea(
              child: Obx(() {
                if (tugasController.isLoadingPre) {
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        CircularProgressIndicator(
                          color: widget.waktuTugas == 2
                              ? Colors.amber.shade600
                              : Colors.blue,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Memuat tugas..",
                          style: TextStyle(
                            color: widget.waktuTugas == 2
                                ? Colors.amber.shade600
                                : Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                      ],
                    ),
                  );
                }
                if (tugasController.isLoading) {
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        CircularProgressIndicator(
                          color: widget.waktuTugas == 2
                              ? Colors.amber.shade600
                              : Colors.blue,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          widget.id == null
                              ? "Mengunggah tugas Anda..."
                              : "Mengubah data tugas...",
                          style: TextStyle(
                            color: widget.waktuTugas == 2
                                ? Colors.amber.shade600
                                : Colors.blue,
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
                  );
                }
                if (tugasController.isSuccess) {
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
                          widget.id == null
                              ? "Tugas berhasil diupload"
                              : "Tugas telah diubah",
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
                            backgroundColor: widget.waktuTugas == 2
                                ? Colors.amber.shade600
                                : Colors.blue,
                            foregroundColor: Colors.white,
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
                return SingleChildScrollView(
                  child: FormBuilder(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  dialogChooseCam();
                                },
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(12),
                                  padding: const EdgeInsets.all(6),
                                  color: tugasController.fileLampiran.path != ""
                                      ? mainColor
                                      : Colors.grey.shade400,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    child: tugasController.fileLampiran.path !=
                                            ""
                                        ? Container(
                                            width: double.infinity,
                                            constraints: const BoxConstraints(
                                                maxHeight: 400),
                                            child: Image.file(
                                              File(tugasController
                                                  .fileLampiran.path),
                                              width: double.infinity,
                                            ),
                                          )
                                        : tugasController.fileUrlExists != ""
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  width: double.infinity,
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxHeight: 400),
                                                  color: Colors.grey.shade200,
                                                  child: Image.network(
                                                    tugasController
                                                        .fileUrlExists,
                                                    fit: BoxFit.cover,
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
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
                                              )
                                            : Container(
                                                height: 125,
                                                width: double.infinity,
                                                color: Colors.grey.shade200,
                                                child: const Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons
                                                          .file_copy_rounded),
                                                      SizedBox(
                                                        width: 6,
                                                      ),
                                                      Text(
                                                        "LAMPIRKAN FILE",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87),
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
                                name: 'judul',
                                decoration: InputDecoration(
                                  labelText: 'Judul',
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
                              FormBuilderTextField(
                                name: 'deskripsi',
                                decoration: InputDecoration(
                                  labelText: 'Deskripsi',
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
                              const SizedBox(height: 12),
                              FormBuilderTextField(
                                name: 'progress',
                                decoration: InputDecoration(
                                  labelText: 'Progress hasil (angka)',
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
                                keyboardType: TextInputType.number,
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
                                maxLines: 5,
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.top,
                              ),
                              const SizedBox(height: 21),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(40, 50),
                                    backgroundColor: widget.waktuTugas == 2
                                        ? Colors.amber.shade600
                                        : Colors.blue,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () async {
                                    if (widget.id == null) {
                                      if (tugasController.fileLampiran.path ==
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
                                    }
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      if (widget.id == null) {
                                        await tugasController.submitSusulan(
                                          formKey.currentState!.value,
                                          widget.waktuTugas,
                                        );
                                        formKey.currentState!.reset();
                                      } else {
                                        await tugasController.submitUpdate(
                                          widget.id ?? "",
                                          formKey.currentState!.value,
                                          widget.waktuTugas,
                                        );
                                      }
                                    }
                                  },
                                  child: Text(
                                    widget.id != null
                                        ? "SIMPAN PERUBAHAN"
                                        : "BUAT TUGAS",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
