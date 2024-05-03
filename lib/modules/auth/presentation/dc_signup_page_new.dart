import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:eofficeapp/modules/auth/controllers/signup_new_controller.dart';
import 'package:eofficeapp/common/configs/config.dart';

import '../../../common/themes/styles.dart';

class DCSignupPageNew extends StatefulWidget {
  const DCSignupPageNew({super.key});

  @override
  State<DCSignupPageNew> createState() => _DCSignupPageNewState();
}

class _DCSignupPageNewState extends State<DCSignupPageNew> {
  final formatDate = DateFormat('yyyy-MM-dd');
  final formKey = GlobalKey<FormBuilderState>();
  late SignUpNewController controller;
  late String idKantor;

  @override
  void initState() {
    super.initState();
    idKantor = Get.arguments['idKantor'];
    print(idKantor); // Anda dapat menggunakan nilai idKantor di sini
    // controller = Get.put(SignUpNewController(idKantor)); // Menggunakan idKantor saat menginisialisasi controller
    controller = Get.put(SignUpNewController(
        idKantor)); // Menggunakan idKantor saat menginisialisasi controller
  }

  Future<void> imagePickerPhoto(ImageSource imgSource) async {
    final controller = Get.find<SignUpNewController>();
    final XFile? image = await ImagePicker().pickImage(
      source: imgSource,
      imageQuality: 50,
    );
    if (image != null) {
      controller.photo = image;
    }
    Get.back();
  }

  modalAddress(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              height: 400,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: FormBuilderTextField(
                      name: 'identity',
                      decoration: InputDecoration(
                        labelText: 'Cari alamat',
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
                      keyboardType: TextInputType.emailAddress,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      onChanged: (value) {
                        controller.dataAddress = [];
                        controller.getAddress(query: value ?? "");
                      },
                    ),
                  ),
                  const Divider(height: 7),
                  Expanded(
                    child: controller.loadingAddress
                        ? const CircularProgressIndicator()
                        : controller.dataAddress.isEmpty
                            ? const Center(
                                child: Icon(
                                  LineIcons.map,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              )
                            : SizedBox(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...controller.dataAddress.map((e) {
                                        return InkWell(
                                          onTap: () {
                                            controller.idAddress =
                                                e.subdistrictId;
                                            controller.valueAddress = e.address;
                                            formKey.currentState!.patchValue({
                                              'subdistrict_value': e.address,
                                            });
                                            Get.back();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                              horizontal: 16,
                                            ),
                                            child: Text(
                                              e.address,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  dialogChooseCam(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FormBuilder(
        key: formKey,
        onChanged: () {
          controller.loadingSubmit = false;
          controller.formError = false;
        },
        child: Center(
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 80),
                  Image.asset(
                    'assets/img_logo.png',
                    height: 150,
                  ),
                  SizedBox(
                    height: controller.loading ? 45 : 0,
                  ),
                  Visibility(
                    visible: controller.loadingSubmit,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 21,
                        ),
                        Text(
                          "Mendaftar...",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: mainColor,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: controller.loading,
                    child: Column(
                      children: [
                        Text(
                          "Memuat Signup...",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: mainColor,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !controller.loading,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 32,
                      ),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Daftar Akun ${Config.namaKantor}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  "Silahkan lengkapi data anda dibawah ini",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                // ... tambahkan widget lainnya di sini
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () => dialogChooseCam(context),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              padding: const EdgeInsets.all(6),
                              color: controller.photo.path != ""
                                  ? mainColor
                                  : Colors.grey.shade400,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                child: controller.photo.path != ""
                                    ? SizedBox(
                                        height: 180,
                                        width: 180,
                                        child: Image.file(
                                          File(controller.photo.path),
                                          height: 180,
                                          width: 180,
                                          fit: BoxFit.cover,
                                        ),
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
                            name: 'username',
                            decoration: InputDecoration(
                              labelText: 'Email',
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
                            keyboardType: TextInputType.emailAddress,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          const SizedBox(height: 12),
                          FormBuilderTextField(
                            name: 'nama_pegawai',
                            decoration: InputDecoration(
                              labelText: 'Nama Pegawai',
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
                            keyboardType: TextInputType.text,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          const SizedBox(height: 12),
                          FormBuilderDateTimePicker(
                            name: 'tgl_lahir',
                            initialEntryMode: DatePickerEntryMode.calendar,
                            inputType: InputType.date,
                            format: formatDate,
                            decoration: InputDecoration(
                              labelText: 'Tgl Lahir',
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
                          InkWell(
                            onTap: () {
                              modalAddress(context);
                            },
                            child: FormBuilderTextField(
                              name: 'subdistrict_value',
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'Pilih Alamat',
                                hintText: 'Pilih Alamat',
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 7,
                                  horizontal: 12,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintStyle:
                                    const TextStyle(color: Colors.black54),
                                labelStyle:
                                    const TextStyle(color: Colors.black54),
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
                              style: const TextStyle(color: Colors.black),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                          ),
                          const SizedBox(height: 12),
                          FormBuilderTextField(
                            name: 'alamat',
                            decoration: InputDecoration(
                              labelText: 'Alamat',
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
                            keyboardType: TextInputType.multiline,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            maxLines: 4,
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical.top,
                          ),
                          const SizedBox(height: 12),
                          FormBuilderDateTimePicker(
                            name: 'tgl_masuk',
                            initialEntryMode: DatePickerEntryMode.calendar,
                            initialValue: DateTime.now(),
                            inputType: InputType.date,
                            format: formatDate,
                            decoration: InputDecoration(
                              labelText: 'Tgl Masuk',
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
                            name: 'wfh',
                            initialValue: formKey.currentState?.value['wfh'],
                            decoration: InputDecoration(
                              labelText: 'Hybrid / WFH',
                              hintText: 'Hybrid / WFH',
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
                            items: const [
                              DropdownMenuItem(
                                value: "1",
                                child: Text("Ya"),
                              ),
                              DropdownMenuItem(
                                value: "0",
                                child: Text("Tidak"),
                              ),
                            ],
                            onChanged: (val) {},
                          ),
                          const SizedBox(height: 12),
                          FormBuilderPhoneField(
                            name: 'no_wa',
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 0,
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
                            dialogTitle: const Text('Pilih Kode Negara'),
                            priorityListByIsoCode: const ['ID'],
                            countryFilterByIsoCode: const ['ID'],
                            defaultSelectedCountryIsoCode: 'ID',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.numeric(),
                              FormBuilderValidators.min(7),
                            ]),
                            keyboardType: TextInputType.number,
                            enabled: true,
                          ),
                          const SizedBox(height: 12),
                          FormBuilderDropdown<String>(
                            name: 'jk',
                            initialValue: formKey.currentState?.value['jk'],
                            decoration: InputDecoration(
                              labelText: 'Jenis Kelamin',
                              hintText: 'Jenis Kelamin',
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
                            items: const [
                              DropdownMenuItem(
                                value: "Laki - Laki",
                                child: Text("Laki - Laki"),
                              ),
                              DropdownMenuItem(
                                value: "Perempuan",
                                child: Text("Perempuan"),
                              ),
                            ],
                            onChanged: (val) {},
                          ),
                          const SizedBox(height: 12),
                          FormBuilderDropdown<String>(
                            name: 'sp',
                            initialValue: formKey.currentState?.value['sp'],
                            decoration: InputDecoration(
                              labelText: 'Status pernikahan',
                              hintText: 'Status pernikahan',
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
                            items: const [
                              DropdownMenuItem(
                                value: "Belum Nikah",
                                child: Text("Belum Nikah"),
                              ),
                              DropdownMenuItem(
                                value: "Sudah Menikah",
                                child: Text("Sudah Menikah"),
                              ),
                              DropdownMenuItem(
                                value: "Janda / Duda",
                                child: Text("Janda / Duda"),
                              ),
                            ],
                            onChanged: (val) {},
                          ),
                          const SizedBox(height: 12),
                          FormBuilderDropdown<String>(
                            name: 'level',
                            initialValue: formKey.currentState?.value['level'],
                            decoration: InputDecoration(
                              labelText: 'Level',
                              hintText: 'Level',
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
                            items: controller.preSignupData.data == null
                                ? []
                                : controller.preSignupData.data!.dataLevel!
                                    .map((a) => DropdownMenuItem(
                                          value: a.id,
                                          child: Text(a.level ?? ""),
                                        ))
                                    .toList(),
                            onChanged: (val) {
                              // formKey.currentState?.save();
                              // if (val == null) {
                              //   return;
                              // }
                            },
                          ),
                          const SizedBox(height: 12),
                          FormBuilderDropdown<String>(
                            name: 'id_jabatan',
                            initialValue:
                                formKey.currentState?.value['id_jabatan'],
                            decoration: InputDecoration(
                              labelText: 'Jabatan',
                              hintText: 'Jabatan',
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
                            items: controller.preSignupData.data == null
                                ? []
                                : controller.preSignupData.data!.dataJabatan!
                                    .map((a) => DropdownMenuItem(
                                          value: a.id,
                                          child: Text(a.jabatan ?? ""),
                                        ))
                                    .toList(),
                            onChanged: (val) {
                              // formKey.currentState?.save();
                              if (val == null) {
                                return;
                              }
                              controller.getTingkat(idJabatan: val);
                            },
                          ),
                          const SizedBox(height: 12),
                          FormBuilderDropdown<String>(
                            name: 'tingkat',
                            decoration: InputDecoration(
                              labelText: 'Tingkat',
                              hintText: 'Tingkat',
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
                            items: controller.dataTingkat
                                .map((a) => DropdownMenuItem(
                                      value: a.id,
                                      child: Text(a.tingkat ?? ""),
                                    ))
                                .toList(),
                            onChanged: (val) {},
                            valueTransformer: (val) => val?.toString(),
                          ),
                          const SizedBox(height: 12),
                          FormBuilderTextField(
                            name: 'password',
                            decoration: InputDecoration(
                              labelText: 'Password',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 7,
                                horizontal: 12,
                              ),
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
                              FormBuilderValidators.min(4),
                            ]),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          const SizedBox(height: 12),
                          FormBuilderTextField(
                            name: 'verify_password',
                            decoration: InputDecoration(
                              labelText: 'Ulangi Password',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 7,
                                horizontal: 12,
                              ),
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
                              FormBuilderValidators.min(4),
                            ]),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          const SizedBox(height: 16),
                          CupertinoButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                await controller
                                    .signup(formKey.currentState!.value);
                                if (controller.formError) {
                                  controller.formError = false;
                                }
                              } else {
                                controller.formError = true;
                              }
                              // if (formKey.currentState!
                              //     .saveAndValidate()) {
                              //   if (controller.loadingSubmit ||
                              //       controller.formError) {
                              //     return;
                              //   } else {
                              //     if (controller.photo.path == "") {
                              //       Get.snackbar(
                              //         "Unggah Foto",
                              //         "Foto harus ada!",
                              //         snackPosition: SnackPosition.TOP,
                              //         backgroundColor: Colors.white,
                              //         margin: const EdgeInsets.symmetric(
                              //           vertical: 12,
                              //           horizontal: 16,
                              //         ),
                              //         icon: const Icon(
                              //           Icons.camera_alt_outlined,
                              //           color: Colors.red,
                              //         ),
                              //         duration: const Duration(seconds: 2),
                              //       );
                              //       return;
                              //     }
                              //     formKey.currentState!.save();
                              //     if (formKey.currentState!
                              //         .validate()) {
                              //       controller.formError = false;

                              //       final response = await controller.signup(
                              //           formKey.currentState!.value);
                              //       if (response) {
                              //       } else {
                              //         // formKey.currentState!.reset();
                              //       }
                              //       return;
                              //     } else {
                              //       controller.formError = true;
                              //     }
                              //   }
                              // }
                            },
                            color:
                                controller.loadingSubmit || controller.formError
                                    ? Colors.grey
                                    : mainColor,
                            child: const Center(
                                child: Text(
                              "DAFTAR",
                              style: TextStyle(
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
