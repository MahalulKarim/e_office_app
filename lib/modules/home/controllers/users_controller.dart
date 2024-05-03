import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/models/users_response.dart';
import 'package:eofficeapp/common/shared/services/users_service.dart';

class UsersController extends GetxController {
  final _data = <UsersData>[].obs;
  List<UsersData> get data => _data;
  set data(List<UsersData> value) => _data.assignAll(value);

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  Future<void> getUserData() async {
    loading = true;
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    final resp =
        await UsersService().getUserData(idUser: (idUser ?? "").toString());
    print('Resp from getUserData: $resp');
    if (resp != null) {
      data = resp;
    }
    loading = false;
  }
}
