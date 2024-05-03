import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:eofficeapp/common/themes/styles.dart';
import 'package:eofficeapp/modules/auth/controllers/forgot_password_controller.dart';
import 'package:pinput/pinput.dart';

class DCForgotPasswordVerifyPage extends StatefulWidget {
  const DCForgotPasswordVerifyPage({Key? key}) : super(key: key);

  @override
  State<DCForgotPasswordVerifyPage> createState() =>
      _DCForgotPasswordVerifyPageState();
}

class _DCForgotPasswordVerifyPageState
    extends State<DCForgotPasswordVerifyPage> {
  int touchedIndex = -1;
  final _formKey = GlobalKey<FormBuilderState>();
  final ForgotPasswordController _controller =
      Get.put(ForgotPasswordController());
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 100, 171, 1);
    // const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color(0x661757AB);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Stack(
      children: [
        Scaffold(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Verifikasi Lupa password",
                                      style: TextStyle(
                                        letterSpacing: 0.6,
                                        color: Colors.black87,
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Isikan kode verifikasi.",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              Obx(
                                () => Pinput(
                                  length: 5,
                                  controller: pinController,
                                  focusNode: focusNode,
                                  autofocus: true,
                                  enabled: !_controller.loadingVerifySubmit,
                                  onCompleted: (pin) async {
                                    final resp =
                                        await _controller.verifyForgotPass({
                                      'phone': Get.arguments['phone'],
                                      'pin': pin,
                                    });
                                    if (resp) {}
                                    _formKey.currentState!.reset();
                                  },
                                  onChanged: (value) {
                                    // debugPrint('onChanged: $value');
                                  },
                                  defaultPinTheme: defaultPinTheme.copyWith(
                                    decoration:
                                        defaultPinTheme.decoration!.copyWith(
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: focusedBorderColor),
                                    ),
                                  ),
                                  disabledPinTheme: defaultPinTheme.copyWith(
                                    decoration:
                                        defaultPinTheme.decoration!.copyWith(
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: focusedBorderColor),
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedPinTheme: defaultPinTheme.copyWith(
                                    decoration:
                                        defaultPinTheme.decoration!.copyWith(
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: focusedBorderColor),
                                    ),
                                  ),
                                  submittedPinTheme: defaultPinTheme.copyWith(
                                    decoration:
                                        defaultPinTheme.decoration!.copyWith(
                                      // color: Colors.grey,
                                      borderRadius: BorderRadius.circular(19),
                                      border:
                                          Border.all(color: focusedBorderColor),
                                    ),
                                  ),
                                  errorPinTheme: defaultPinTheme.copyBorderWith(
                                    border: Border.all(color: Colors.redAccent),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 17),
                              const SizedBox(height: 32),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () => Get.back(),
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
      ],
    );
  }
}
