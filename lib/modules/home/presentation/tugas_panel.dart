import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/models/project_board_response.dart';
import 'package:eofficeapp/modules/home/controllers/tugas_panel_controller.dart';
import 'package:eofficeapp/modules/home/controllers/project_controller.dart';
import 'package:eofficeapp/modules/home/controllers/users_controller.dart';

import 'package:eofficeapp/modules/home/presentation/item_project_board.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:eofficeapp/common/models/project_response.dart'; // Import paket flutter_form_builder
import 'package:eofficeapp/common/models/users_response.dart'; // Import paket flutter_form_builder

class TugasPanel extends StatefulWidget {
  const TugasPanel({Key? key}) : super(key: key);

  @override
  TugasPanelState createState() => TugasPanelState();
}

class TugasPanelState extends State<TugasPanel> {
  late TugasPanelController controller;
  late ProjectController projectController;

  late UsersController userController;

  String? selectedProject;
  List<String> selectedProjects = [];
  List<String> selectedUsers = []; // Deklarasi variabel selectedProjects
  GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    controller = Get.put(TugasPanelController());
    projectController = Get.put(ProjectController());
    userController = Get.put(UsersController());
    UsersController().getUserData().then((_) {
      print('Project Data: ${userController.data}');
      print('Project Data: ${projectController.data}');
      Get.back();
    });
    super.initState();
  }

  Future<void> updateTasks({
    required String id,
    required String status,
  }) async {
    await controller.updateStatus(
      id: id,
      status: status,
    );
    Get.back();
  }

  openDialog(ProjectBoardData data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(data.task ?? "Kelola Tugas"),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          content: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                data.idStatus != "1"
                    ? Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: TextButton(
                          onPressed: controller.loading
                              ? null
                              : () async {
                                  await updateTasks(
                                      id: data.id ?? "", status: "1");
                                },
                          child: Text(
                            "Pindah ke TO DO",
                            style: controller.loading
                                ? const TextStyle(color: Colors.grey)
                                : const TextStyle(color: Colors.amber),
                          ),
                        ),
                      )
                    : const SizedBox(),
                data.idStatus != "2"
                    ? Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: TextButton(
                          onPressed: controller.loading
                              ? null
                              : () async {
                                  await updateTasks(
                                      id: data.id ?? "", status: "2");
                                },
                          child: Text(
                            "Pindah ke ON PROGRESS",
                            style: controller.loading
                                ? const TextStyle(color: Colors.grey)
                                : const TextStyle(color: Colors.blue),
                          ),
                        ),
                      )
                    : const SizedBox(),
                data.idStatus != "3"
                    ? Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: TextButton(
                          onPressed: controller.loading
                              ? null
                              : () async {
                                  await updateTasks(
                                      id: data.id ?? "", status: "3");
                                },
                          child: Text(
                            "Pindah ke FINISH",
                            style: controller.loading
                                ? const TextStyle(color: Colors.grey)
                                : const TextStyle(color: Colors.green),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget listProjectBoard(String status) {
    // if (!controller.loading) {
    if (controller.data
        .where((element) => element.idStatus == status)
        .isNotEmpty) {
      return Column(
        children: [
          ...controller.data
              .where((element) => element.idStatus == status)
              .map((e) {
            return ItemProjectBoard(
              data: e,
              onPressed: () {
                openDialog(e);
              },
            );
          }).toList()
        ],
      );
    } else {
      return const SizedBox(
        width: double.infinity,
        child: Center(
          child: Icon(
            Icons.filter_list_off,
            color: Colors.black87,
          ),
        ),
      );
    }
    // }
    // return const SizedBox();
  }

  void showProgressModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        double halfScreenHeight = MediaQuery.of(context).size.height * 0.5;

        return FormBuilder(
          key: _formKey, // Deklarasikan GlobalKey<FormBuilderState> _formKey
          child: Container(
            margin: EdgeInsets.all(16),
            height: halfScreenHeight,
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.center,
              child: ListView(
                children: [
                  Text(
                    'Tambah Tugas - TO DO',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  FormBuilderDropdown<String>(
                    name: 'project',
                    initialValue: selectedProject,
                    decoration: InputDecoration(
                      labelText: 'Pilih Proyek',
                      hintText: 'Pilih Proyek',
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
                    items: (projectController.data ?? [])
                        .map<DropdownMenuItem<String>>(
                      (dynamic project) {
                        if (project is ProjectData) {
                          return DropdownMenuItem<String>(
                            value: project
                                .id!, // Menggunakan non-null assertion karena kita yakin id tidak null
                            child: Text(project
                                .project!), // Menggunakan non-null assertion karena kita yakin project tidak null
                          );
                        } else {
                          throw Exception(
                              "Data yang diterima bukan instance dari ProjectData");
                        }
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedProject = val;
                      });
                    },
                  ),
                  SizedBox(height: 12),
                  FormBuilderCheckboxGroup(
                    name: 'selectedUsers',
                    initialValue: [],
                    decoration: InputDecoration(
                      labelText: 'Tandai Teman',
                      hintText: 'Tandai Teman',
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
                    options:
                        (userController.data.isEmpty ? [] : userController.data)
                            .map((user) {
                      return FormBuilderFieldOption(
                        value: user.id!,
                        child: Text(user.name!),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedUsers = val?.cast<String>() ?? [];
                      });
                    },
                  ),
                  SizedBox(height: 12),
                  FormBuilderTextField(
                    name: 'taskTitle',
                    decoration: InputDecoration(
                      labelText: 'Judul Tugas',
                      hintText: 'Judul Tugas',
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
                          )),
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
                  SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'taskDescription',
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Deskripsi Tugas',
                      hintText: 'Deskripsi Tugas',
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
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.saveAndValidate()) {
                        String taskTitle =
                            _formKey.currentState!.value['taskTitle'];
                        String taskDescription =
                            _formKey.currentState!.value['taskDescription'];
                        String projectId =
                            _formKey.currentState!.value['project'];
                        List<String> selectedUsers = (_formKey.currentState!
                                .value['selectedUsers'] as List<dynamic>)
                            .map((user) => user.toString())
                            .toList();

                        // Menyimpan data ke server atau melakukan tindakan lainnya.
                        // Contoh menggunakan projectController
                        await projectController.saveData(taskTitle,
                            taskDescription, projectId, selectedUsers);

                        // Panggil fungsi untuk mereload data pada halaman sebelum menutup modal
                        await projectController.getData2();

                        await updateTasks(id: "", status: "1");

                        _formKey.currentState!.reset();
                        // Tutup modal setelah menyimpan data
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                    ),
                    child: Text('Simpan'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.yellow.shade100,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "TO DO",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                listProjectBoard("1"),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                // color: Colors.blueAccent.shade100,
                ),
            // padding: const EdgeInsets.symmetric(
            //   vertical: 8,
            //   horizontal: 12,
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.max,
              children: [
                // const Text(
                //   "ON PROGRESS",
                //   style: TextStyle(
                //     fontSize: 17,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                SizedBox(height: 8), // Sesuaikan jarak sesuai kebutuhan
                ElevatedButton(
                  onPressed: () {
                    showProgressModal(); // Panggil fungsi untuk menampilkan modal
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:
                      Text('Tambah Tugas'), // Sesuaikan teks sesuai kebutuhan
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueAccent.shade100,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "ON PROGRESS",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                listProjectBoard("2"),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green.shade200,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "FINISH",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                listProjectBoard("3"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
