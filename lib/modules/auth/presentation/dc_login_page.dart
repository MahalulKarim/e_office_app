import 'package:eofficeapp/modules/logo-banner/logo_banner.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:eofficeapp/common/themes/styles.dart';
import 'package:eofficeapp/modules/auth/controllers/auth_controller.dart';
import 'package:eofficeapp/modules/auth/controllers/cek_kantor_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class DCLoginPage extends StatefulWidget {
  const DCLoginPage({Key? key}) : super(key: key);

  @override
  State<DCLoginPage> createState() => _DCLoginPageState();
}

class _DCLoginPageState extends State<DCLoginPage> {
  String idKantor = '';
  TextEditingController myController = TextEditingController();
  int touchedIndex = -1;
  final _formKey = GlobalKey<FormBuilderState>();
  // final _formKey2 = GlobalKey<FormBuilderState>();
  final AuthController _controller = Get.put(AuthController());
  final CekKantorController _cekKantorController =
      Get.put(CekKantorController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Scaffold(
        //   resizeToAvoidBottomInset: false,
        //   backgroundColor: Colors.white,
        //   body: Container(
        //     constraints: const BoxConstraints.expand(),
        //     child: SafeArea(
        //       child: Stack(
        //         children: <Widget>[
        //           Positioned(
        //             left: 0,
        //             bottom: 0,
        //             right: 0,
        //             child: Image.asset(
        //               'assets/working-office.png',
        //               width: double.infinity,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        Obx(
          () => Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              constraints: const BoxConstraints.expand(),
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Image.asset(
                          'assets/img_logo.png',
                          height: 70,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 24,
                            horizontal: 32,
                          ),
                          width: double.infinity,
                          child: FormBuilder(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 0,
                                  ),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Login",
                                        style: TextStyle(
                                          letterSpacing: 0.6,
                                          color: Colors.black,
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Isikan akun anda dibawah ini",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
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
                                  enabled: !_controller.loadingSubmit,
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
                                  enabled: !_controller.loadingSubmit,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed('/forgot_password');
                                  },
                                  child: Text(
                                    "Lupa password?",
                                    style: TextStyle(
                                      color: mainColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 17),
                                Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(10),
                                  animationDuration:
                                      const Duration(milliseconds: 500),
                                  child: InkWell(
                                    onTap: !_controller.loadingSubmit
                                        ? () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();
                                              _controller.loadingSubmit = true;
                                              final resp = await _controller
                                                  .login(_formKey
                                                      .currentState!.value);
                                              _controller.loadingSubmit = false;
                                              if (resp == "success") {
                                                Get.offAllNamed('/splash');
                                              }
                                              _formKey.currentState!.reset();
                                            }
                                          }
                                        : () {},
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                      decoration: BoxDecoration(
                                        color: !_controller.loadingSubmit
                                            ? mainColor
                                            : mainColor.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: !_controller.loadingSubmit
                                            ? const Text(
                                                "MASUK",
                                                style: TextStyle(
                                                  letterSpacing: 0.7,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              )
                                            : const Text(
                                                "Tunggu sebentar...",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Belum punya akun?",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      InkWell(
                                        // onTap: () {
                                        //   Get.toNamed('/signup')!.then((value) {
                                        //     if (value == null) {
                                        //       return;
                                        //     }
                                        //     if (value['msg'] == null) {
                                        //       return;
                                        //     }
                                        //     Get.snackbar(
                                        //       "Daftar Berhasil!",
                                        //       value['msg'],
                                        //       snackPosition: SnackPosition.TOP,
                                        //       backgroundColor: Colors.white,
                                        //       margin:
                                        //           const EdgeInsets.symmetric(
                                        //               vertical: 12,
                                        //               horizontal: 16),
                                        //       icon: const Icon(
                                        //           Icons
                                        //               .check_circle_outline_outlined,
                                        //           color: Colors.green),
                                        //       duration:
                                        //           const Duration(seconds: 2),
                                        //     );
                                        //   });
                                        // },

                                        child: TextButton(
                                          onPressed: () => showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: const Text('Cari Kantor'),
                                              content: SizedBox(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextFormField(
                                                      controller: myController,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          idKantor =
                                                              value; // Simpan nilai input pengguna ke dalam variabel idKantor
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        fillColor: const Color(
                                                            0xffF1F0F5),
                                                        filled: true,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          borderSide:
                                                              const BorderSide(),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          borderSide:
                                                              const BorderSide(),
                                                        ),
                                                        labelText:
                                                            'Kode Kantor *',
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Row(
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            String? namaKantor =
                                                                await _cekKantorController
                                                                    .cekKodeKantor(
                                                                        idKantor); // Memastikan nama fungsi yang dipanggil adalah cekIdKantor
                                                            if (namaKantor !=
                                                                null) {
                                                              // ignore: use_build_context_synchronously
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    // title: const Text('Hasil Cari Kantor'),
                                                                    content:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        const Text(
                                                                            "Anda terdaftar di Kantor:"),
                                                                        const SizedBox(
                                                                          height:
                                                                              24,
                                                                        ),
                                                                        Text(
                                                                            namaKantor,
                                                                            style:
                                                                                TextStyle(color: mainColor, fontSize: 15)),
                                                                      ],
                                                                    ),
                                                                    actions: <Widget>[
                                                                      ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Get.toNamed('/signup', arguments: {
                                                                            'idKantor':
                                                                                idKantor
                                                                          })!
                                                                              .then((value) {
                                                                            if (value ==
                                                                                null) {
                                                                              return;
                                                                            }
                                                                            if (value['msg'] ==
                                                                                null) {
                                                                              return;
                                                                            }
                                                                            Get.snackbar(
                                                                              "Daftar Berhasil!",
                                                                              value['msg'],
                                                                              snackPosition: SnackPosition.TOP,
                                                                              backgroundColor: Colors.white,
                                                                              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                                                              icon: const Icon(Icons.check_circle_outline_outlined, color: Colors.green),
                                                                              duration: const Duration(seconds: 2),
                                                                            );
                                                                            Navigator.of(context).pop();
                                                                          });
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              Colors.blue,
                                                                          foregroundColor:
                                                                              Colors.white,
                                                                          surfaceTintColor:
                                                                              Colors.blue,
                                                                        ),
                                                                        child: const Text(
                                                                            "Lanjutkan"),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            'Batal'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            } else {
                                                              // ignore: use_build_context_synchronously
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title: const Text(
                                                                        'Hasil Cari Kantor'),
                                                                    content:
                                                                        const SizedBox(
                                                                      height:
                                                                          150,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Text(
                                                                              "Kantor Tidak Valid"),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    actions: <Widget>[
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            'Close'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            }
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.blue,
                                                            foregroundColor:
                                                                Colors.white,
                                                            surfaceTintColor:
                                                                Colors.blue,
                                                          ),
                                                          child: const Text(
                                                            'CARI',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  'Cancel'),
                                                          child: const Text(
                                                              'Cancel'),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                    const Text(
                                                        "Belum punya kantor dan ingin menggunakan EOFFICE S4I? "),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            await launchUrl(
                                                                Uri.parse(
                                                                    'https://app.eoffice.my.id/registerkantor'));
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.green,
                                                            foregroundColor:
                                                                Colors.white,
                                                            surfaceTintColor:
                                                                Colors.green,
                                                          ),
                                                          child: const Text(
                                                              "Registrasi Kantor"),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ), // Ganti nilai ini dengan tinggi yang diinginkan
                                              ),
                                              // actions: <Widget>[
                                              // ],
                                            ),
                                          ),
                                          child: Text(
                                            'Daftar Sekarang',
                                            style: TextStyle(
                                              color: mainColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        // child: Text(
                                        //   "Daftar",
                                        //   style: TextStyle(
                                        //     color: mainColor,
                                        //     fontSize: 15,
                                        //   ),
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                const LogoBanner(),
                                const SizedBox(
                                  height: 60,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
