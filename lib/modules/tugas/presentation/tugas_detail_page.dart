import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../tugas_form/presentation/form_tugas_page.dart';

class TugasDetailPage extends StatelessWidget {
  const TugasDetailPage({
    Key? key,
    required this.id,
    required this.type,
    required this.tgl,
    required this.title,
    required this.subtitle,
    this.ket,
    this.progress,
    this.urlPhoto,
  }) : super(key: key);

  final int id;
  final int type;
  final String tgl;
  final String title;
  final String subtitle;
  final String? ket;
  final String? progress;
  final String? urlPhoto;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Image.network(
              urlPhoto ?? "",
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: Stack(
                    children: [
                      const Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
              // statusBarColor: type == 1
              //     ? Colors.blue
              //     : type == 2
              //         ? Colors.amber.shade600
              //         : Colors.red,
              statusBarColor: Colors.black38,
            ),
            elevation: 0,
            backgroundColor: Colors.white38,
            foregroundColor: Colors.white,
            toolbarHeight: 65,
            actions: [
              IconButton(
                onPressed: () {
                  Get.back();
                  Get.to(
                    () => FormTugasPage(
                      waktuTugas: type,
                      id: id.toString(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit_note,
                  size: 30,
                ),
              ),
            ],
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type == 1
                    ? "Tugas Pagi"
                    : type == 2
                        ? "Tugas Siang"
                        : "Tugas Tanggungan"),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  tgl != ""
                      ? DateFormat('dd-MM-yyyy').format(DateTime.now()) ==
                              DateFormat('dd-MM-yyyy')
                                  .format(DateFormat('dd-MM-yyyy').parse(tgl))
                          ? "Hari Ini"
                          : DateFormat('dd MMMM yyyy')
                              .format(DateFormat('dd-MM-yyyy').parse(tgl))
                      : "-",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 28,
                      horizontal: 16,
                    ),
                    width: double.infinity,
                    color: Colors.black38,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                subtitle,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: ket == null ? 0 : 4,
                              ),
                              ket == null
                                  ? const SizedBox()
                                  : Text(
                                      ket ?? "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: progress != null && progress != "" ? 12 : 0,
                        ),
                        progress != null && progress != ""
                            ? CircleAvatar(
                                backgroundColor: type == 1
                                    ? Colors.blue
                                    : type == 2
                                        ? Colors.amber.shade600
                                        : Colors.red,
                                foregroundColor: Colors.white,
                                radius: 27,
                                child: Text(
                                  "${progress ?? ""}%",
                                  style: const TextStyle(fontSize: 18),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
