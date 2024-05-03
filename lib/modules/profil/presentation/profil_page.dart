import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/themes/styles.dart';
import '../controllers/profil_controller.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  ProfilPageState createState() => ProfilPageState();
}

class ProfilPageState extends State<ProfilPage> {
  late ProfilController profilController;
  final imgPicker = ImagePicker();

  @override
  void initState() {
    profilController = Get.put(ProfilController());
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
                    await imagePickerPhoto(ImageSource.gallery);
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
                    await imagePickerPhoto(ImageSource.camera);
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

  Future<void> imagePickerPhoto(ImageSource imgSource) async {
    final XFile? image = await imgPicker.pickImage(
      source: imgSource,
      imageQuality: 50,
    );
    if (image != null) {
      profilController.photo = image;
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
        title: const Text("Profil"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              child: Obx(
                () => FormBuilder(
                  key: profilController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          dialogChooseCam();
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(6),
                          color: profilController.photo.path != ""
                              ? mainColor
                              : Colors.grey.shade400,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            child: profilController.photo.path != ""
                                ? SizedBox(
                                    height: 180,
                                    width: 180,
                                    child: Image.file(
                                      File(profilController.photo.path),
                                      height: 180,
                                      width: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : profilController.urlFoto != ""
                                    ? Stack(
                                        children: [
                                          SizedBox(
                                            height: 180,
                                            width: 180,
                                            child: Image.network(
                                              profilController.urlFoto,
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
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6),
                                                color: Colors.white70,
                                                child: Text(
                                                  "Ganti foto",
                                                  style: TextStyle(
                                                    color: mainColor,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(
                                        height: 180,
                                        width: 180,
                                        color: Colors.grey.shade200,
                                        child: const Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.person,
                                                size: 70,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                "FOTO",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                ),
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
                        name: 'email',
                        decoration: InputDecoration(
                          labelText: 'Email',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 12,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),
                      FormBuilderTextField(
                        name: 'old_password',
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password Saat Ini',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 12,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 12),
                      FormBuilderTextField(
                        name: 'password',
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password Baru',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 12,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (profilController.formKey.currentState!
                                  .fields['old_password']!.value !=
                              null) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            } else if (value.length < 8) {
                              return 'Password minimal 6 karakter';
                            }
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(10),
                        animationDuration: const Duration(milliseconds: 500),
                        child: InkWell(
                          onTap: profilController.loadingSubmit
                              ? null
                              : () async {
                                  if (profilController.formKey.currentState!
                                      .validate()) {
                                    profilController.formKey.currentState!
                                        .save();
                                    final response = await profilController
                                        .updateData(profilController
                                            .formKey.currentState!.value);
                                    if (response) {
                                      Get.back();
                                      Get.snackbar(
                                        "Update berhasil!",
                                        "Ubah profil berhasil",
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: Colors.white,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        icon: const Icon(Icons.check_circle,
                                            color: Colors.green),
                                        duration: const Duration(seconds: 2),
                                      );
                                    } else {
                                      Get.snackbar(
                                        "Update terkendala!",
                                        "Silahkan ulangi lagi",
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: Colors.white,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        icon: const Icon(Icons.warning,
                                            color: Colors.red),
                                        duration: const Duration(seconds: 2),
                                      );
                                    }
                                  }
                                },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: profilController.loadingSubmit
                                  ? Colors.grey
                                  : Colors.blueGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                                child: Text(
                              "SIMPAN",
                              style: TextStyle(
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
