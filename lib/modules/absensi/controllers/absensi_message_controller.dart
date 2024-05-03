import 'package:get/get.dart';
import 'package:eofficeapp/common/shared/services/kata_bijak_service.dart';

class AbsensiMessageController extends GetxController {
  late KataBijakService kataBijakService;

  final _kalimatBijak = "".obs;
  String get kalimatBijak => _kalimatBijak.value;
  set kalimatBijak(String value) => _kalimatBijak.value = value;

  @override
  void onInit() {
    kataBijakService = Get.put(KataBijakService());
    getKalimat();
    super.onInit();
  }

  Future<void> getKalimat() async {
    try {
      final response = await kataBijakService.getKalimat();
      kalimatBijak = response['data']['kalimat'];
    } catch (e) {}
  }
}
