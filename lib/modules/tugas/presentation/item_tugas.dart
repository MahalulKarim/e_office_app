import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/models/tugas_response.dart';
import 'package:eofficeapp/modules/tugas/presentation/tugas_detail_page.dart';
import 'package:eofficeapp/modules/tugas_form/presentation/form_tugas_page.dart';

class ItemTugas extends StatelessWidget {
  const ItemTugas({
    Key? key,
    required this.dataTugas,
    required this.dataUpload,
  }) : super(key: key);

  final Tugas dataTugas;
  final ListUploadTugas dataUpload;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => TugasDetailPage(
            id: int.parse(dataUpload.id ?? "0"),
            type: int.parse(dataUpload.waktu ?? "1"),
            tgl: dataUpload.tgl ?? "",
            title: dataTugas.judul ?? "",
            subtitle: dataTugas.tugas ?? "",
            ket: dataUpload.ket ?? "",
            progress: dataTugas.progress,
            urlPhoto: (dataUpload.urlFile != null && dataUpload.urlFile != "")
                ? dataUpload.urlFile
                : null,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        // margin: const EdgeInsets.only(right: 6, left: 6, top: 8, bottom: 0),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          // borderRadius: BorderRadius.circular(16),
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.blueGrey.shade100,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  dataUpload.urlFile == null || dataUpload.urlFile == ""
                      ? const SizedBox()
                      : ClipRRect(
                          // borderRadius: const BorderRadius.only(
                          //   topLeft: Radius.circular(16),
                          //   topRight: Radius.circular(16),
                          // ),
                          child: Container(
                            width: double.infinity,
                            height: 160,
                            color: Colors.grey.shade200,
                            child: Image.network(
                              dataUpload.urlFile ?? "",
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                      right: 6,
                      left: 16,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              dataTugas.judul != null && dataTugas.judul != ""
                                  ? Text(
                                      dataTugas.judul ?? "-",
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                  height: (dataTugas.judul != null &&
                                              dataTugas.judul != "") &&
                                          (dataTugas.tugas != null &&
                                              dataTugas.tugas != "")
                                      ? 2
                                      : 0),
                              dataTugas.tugas != null && dataTugas.tugas != ""
                                  ? Text(
                                      dataTugas.tugas ?? "-",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                  height: ((dataTugas.judul != null &&
                                                  dataTugas.judul != "") ||
                                              (dataTugas.tugas != null &&
                                                  dataTugas.tugas != "")) &&
                                          (dataUpload.ket != null &&
                                              dataUpload.ket != "")
                                      ? 2
                                      : 0),
                              dataUpload.ket != null && dataUpload.ket != ""
                                  ? Text(
                                      dataUpload.ket ?? "-",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        dataTugas.progress != null && dataTugas.progress != ""
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: CircleAvatar(
                                  backgroundColor: dataUpload.waktu == "1"
                                      ? Colors.blue
                                      : dataUpload.waktu == "2"
                                          ? Colors.amber.shade600
                                          : Colors.red,
                                  foregroundColor: Colors.white,
                                  radius: 20,
                                  child: Text(
                                    (dataTugas.progress ?? "") + "%",
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        IconButton(
                          onPressed: () {
                            Get.to(
                              () => FormTugasPage(
                                waktuTugas: int.parse(dataUpload.waktu ?? "1"),
                                id: dataUpload.id,
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit_note,
                            color: Colors.blueGrey,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
