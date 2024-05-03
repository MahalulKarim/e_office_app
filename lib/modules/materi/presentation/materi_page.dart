import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:eofficeapp/modules/materi/controllers/materi_controller.dart';
import 'package:eofficeapp/modules/materi/presentation/materi_detail_page.dart';

class MateriPage extends StatelessWidget {
  const MateriPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MateriController());

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Materi')),
      body: Column(
        children: [
          Obx(
            () => Visibility(
              visible: controller.loading,
              child: const LinearProgressIndicator(),
            ),
          ),
          Obx(
            () => Container(
              padding: const EdgeInsets.all(6),
              child: FormBuilder(
                key: controller.formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: FormBuilderTextField(
                          name: 'query',
                          onEditingComplete: () {
                            controller.formKey.currentState?.save();
                            controller.loadData(false);
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            isDense: true,
                            hintText: 'Cari judul materi',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: FormBuilderDropdown(
                          name: 'jenis_materi',
                          initialValue: controller
                              .formKey.currentState?.value['jenis_materi'],
                          onChanged: (value) {
                            controller.formKey.currentState!.save();
                            controller.loadData(false);
                          },
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: 'Pilih jenis materi',
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            const DropdownMenuItem(
                              value: '',
                              child: Text('Pilih Jenis Materi'),
                            ),
                            ...controller.listJenisMateri
                                .map((e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.jenisMateri),
                                    ))
                                .toList()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView(
                children: [
                  ListView.separated(
                    separatorBuilder: (c, i) => const Divider(),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (c, i) {
                      final materi = controller.materi[i];
                      return ListTile(
                        onTap: () =>
                            Get.to(() => const MateriDetailPage(), arguments: {
                          "materi": materi,
                        }),
                        leading: const CircleAvatar(
                          child: Icon(LineIcons.book),
                        ),
                        title: Text(materi.namaMateri),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(materi.jenisMateri),
                            const SizedBox(height: 6),
                            Text(
                              DateFormat('dd/MM/yyyy HH:mm:ss')
                                  .format(DateTime.parse(materi.tgl)),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: controller.materi.length,
                  ),
                  TextButton(
                    child: const Text(
                      'Muat lebih banyak',
                    ),
                    onPressed: () => controller.loadMore(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
