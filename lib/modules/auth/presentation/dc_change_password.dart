import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/themes/styles.dart';
import 'package:eofficeapp/modules/auth/controllers/change_password_controller.dart';

class DCChangePassword extends StatefulWidget {
  const DCChangePassword({Key? key}) : super(key: key);

  @override
  DCChangePasswordState createState() => DCChangePasswordState();
}

class DCChangePasswordState extends State<DCChangePassword> {
  final _formKey = GlobalKey<FormBuilderState>();
  final ChangePasswordController _controller =
      Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Center(
            child: Obx(
              () => SingleChildScrollView(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Ubah Password",
                                    style: TextStyle(
                                      letterSpacing: 0.6,
                                      color: Colors.black87,
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Silahkan ubah password anda",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            FormBuilderTextField(
                              name: 'password_new',
                              decoration: InputDecoration(
                                labelText: 'Password baru',
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
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _controller.obscureText =
                                        !_controller.obscureText;
                                  },
                                  icon: _controller.obscureText
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.min(4),
                              ]),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _controller.obscureText,
                            ),
                            const SizedBox(height: 12),
                            FormBuilderTextField(
                              name: 'password_new_confirm',
                              decoration: InputDecoration(
                                labelText: 'Konfirmasi password baru',
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
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _controller.obscureText =
                                        !_controller.obscureText;
                                  },
                                  icon: _controller.obscureText
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.min(4),
                              ]),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _controller.obscureText,
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(14),
                              animationDuration:
                                  const Duration(milliseconds: 500),
                              child: InkWell(
                                onTap: !_controller.loadingSubmit
                                    ? () async {
                                        if (_formKey.currentState!.validate()) {
                                          if (_formKey.currentState!
                                                  .value['password_new'] !=
                                              _formKey.currentState!.value[
                                                  'password_new_confirm']) {
                                            Get.snackbar(
                                              "Password incorrect!",
                                              "Password tidak sama",
                                              snackPosition: SnackPosition.TOP,
                                              backgroundColor: Colors.white,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                              icon: const Icon(
                                                  Icons.offline_bolt,
                                                  color: Colors.red),
                                              duration:
                                                  const Duration(seconds: 2),
                                            );
                                          } else {
                                            _formKey.currentState!.save();
                                            await _controller.changePass(
                                                Get.arguments['phone'],
                                                Get.arguments['ncc'],
                                                _formKey.currentState!.value);
                                            _formKey.currentState!.reset();
                                          }
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
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Center(
                                    child: !_controller.loadingSubmit
                                        ? const Text(
                                            "UBAH PASSWORD",
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
                            const SizedBox(height: 32),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () => Get.offAllNamed('/'),
                                    child: Text(
                                      "Kembali",
                                      style: TextStyle(
                                        color: mainColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
