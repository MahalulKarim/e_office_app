import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:eofficeapp/common/themes/styles.dart';
import 'package:eofficeapp/modules/auth/controllers/forgot_password_controller.dart';

class DCForgotPasswordPage extends StatefulWidget {
  const DCForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<DCForgotPasswordPage> createState() => _DCForgotPasswordPageState();
}

class _DCForgotPasswordPageState extends State<DCForgotPasswordPage> {
  int touchedIndex = -1;
  final _formKey = GlobalKey<FormBuilderState>();
  final ForgotPasswordController _controller =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
                        Image.asset(
                          'assets/img_logo.png',
                          height: 60,
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
                                        "Lupa password",
                                        style: TextStyle(
                                          letterSpacing: 0.6,
                                          color: Colors.black87,
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Isikan nomor anda dibawah ini, untuk selanjutnya akan menerima kode verifikasi.",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                FormBuilderPhoneField(
                                  name: 'phone',
                                  decoration: InputDecoration(
                                    labelText: 'Nomor HP',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 7,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                        width: 1,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
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
                                  enabled: !_controller.loadingSubmit,
                                ),
                                const SizedBox(height: 17),
                                Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(14),
                                  animationDuration:
                                      const Duration(milliseconds: 500),
                                  child: InkWell(
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        _controller.loadingSubmit = true;
                                        final resp =
                                            await _controller.submitForgotPass(
                                                _formKey.currentState!.value);
                                        _controller.loadingSubmit = false;
                                        if (resp) {
                                          Get.toNamed('/forgot_password_verify',
                                              arguments: {
                                                'phone': _formKey.currentState!
                                                    .value['phone'],
                                              });
                                        }
                                        _formKey.currentState!.reset();
                                      }
                                    },
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
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Center(
                                        child: !_controller.loadingSubmit
                                            ? const Text(
                                                "SUBMIT",
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
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Sudah punya akun?",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      InkWell(
                                        onTap: () => Get.back(),
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                            color: mainColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
