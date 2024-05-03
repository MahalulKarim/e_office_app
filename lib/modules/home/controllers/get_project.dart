import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/models/project_board_response.dart';
import 'package:eofficeapp/common/shared/services/project_board_service.dart';

class TugasPanelController extends GetxController {
  final _data = <ProjectBoardData>[].obs;
  List<ProjectBoardData> get data => _data;
  set data(List<ProjectBoardData> value) => _data.assignAll(value);

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  @override
  void onInit() {
    super.onInit();
    getData();
    // getProject();
  }

  Future<void> updateStatus({
    required String id,
    required String status,
  }) async {
    loading = true;
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    await ProjectBoardService().update(
      id: id,
      idUser: idUser ?? "",
      idStatus: status,
    );
    await getData();
  }

  Future<void> getData() async {
    loading = true;
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    final resp =
        await ProjectBoardService().getData(idUser: (idUser ?? "").toString());
    if (resp != null) {
      data = resp.data;
    }
    loading = false;
  }
}
