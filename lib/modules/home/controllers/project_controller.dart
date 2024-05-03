import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/models/project_response.dart';
import 'package:eofficeapp/common/shared/services/project_service.dart';

class ProjectController extends GetxController {
  final _data = <ProjectData>[].obs;
  List<ProjectData> get data => _data;
  set data(List<ProjectData> value) => _data.assignAll(value);

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  @override
  void onInit() {
    super.onInit();
    getData2();
  }

  Future<void> getData2() async {
    loading = true;
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    final resp =
        await ProjectService().getData2(idUser: (idUser ?? "").toString());
    if (resp != null) {
      data = resp;
    }
    loading = false;
  }

  Future<void> saveData(String taskTitle, String taskDescription,
      String projectId, List<String>? selectedUsers) async {
    try {
      const storage = FlutterSecureStorage();
      var idUser = await storage.read(key: 'id_user');

      // Lakukan penyimpanan data dengan memanggil metode saveData dari ProjectService
      await ProjectService().saveData(
          taskTitle, taskDescription, projectId, idUser, selectedUsers ?? []);

      // Jika Anda memerlukan pembaruan data setelah penyimpanan, Anda dapat memanggil kembali getData2.
      await getData2();

      // Jika Anda memiliki logika lain yang perlu dijalankan setelah penyimpanan, lakukan di sini.
      // print('Received task data:');
      // print('Project ID: $projectId');
      // print('Task Title: $taskTitle');
      // print('Task Description: $taskDescription');
    } catch (error) {
      // Handle kesalahan jika diperlukan
      // print('Error saving project data: $error');
    }
  }
}
