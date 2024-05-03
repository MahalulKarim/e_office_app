import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/themes/styles.dart';

import '../controllers/absensi_message_controller.dart';

class AbsensiMessagePage extends StatelessWidget {
  const AbsensiMessagePage({
    Key? key,
    this.status = 'success',
    required this.msg,
    this.ket = '',
    this.showStatusIn = true,
  }) : super(key: key);

  final String status;
  final String msg;
  final String ket;
  final bool showStatusIn;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AbsensiMessageController());
    final absensiMessageController = Get.find<AbsensiMessageController>();

    return WillPopScope(
      onWillPop: () {
        absensiMessageController.getKalimat();
        Get.back();
        Get.back();
        return Future(() => false);
      },
      child: Obx(
        () => Scaffold(
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: mainColor.shade800,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    msg,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: showStatusIn ? 10 : 0,
                  ),
                  showStatusIn
                      ? Text(
                          ket,
                          style: TextStyle(
                            fontSize: 18,
                            color: status == "success"
                                ? mainColor
                                : status == "danger"
                                    ? Colors.red
                                    : Colors.amber,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 16,
                  ),
                  absensiMessageController.kalimatBijak != ""
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.shade100,
                                spreadRadius: 1,
                                blurRadius: 4,
                              )
                            ],
                          ),
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 10,
                            bottom: 16,
                          ),
                          margin: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const Text("Kata bijak hari ini : "),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                absensiMessageController.kalimatBijak,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      absensiMessageController.getKalimat();
                      Get.back();
                      Get.back();
                    },
                    child: const Text("<< Kembali"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
