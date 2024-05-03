import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:eofficeapp/common/models/materi_response.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../common/configs/config.dart' as c;

class MateriDetailController extends GetxController {}

class MateriDetailPage extends StatefulWidget {
  const MateriDetailPage({super.key});

  @override
  State<MateriDetailPage> createState() => _MateriDetailPageState();
}

class _MateriDetailPageState extends State<MateriDetailPage> {
  final Materi materi = Get.arguments['materi'];

  double progressDownload = 0;
  bool isDownloaded = false;
  String downloadPath = '';
  late File checkFile;

  @override
  void initState() {
    initDownloadStorage();
    super.initState();
  }

  Future<String> getDownloadDirectoryPath() async {
    Directory? externalDirectory = await getExternalStorageDirectory();

    return '${externalDirectory!.path}/Download';
  }

  initDownloadStorage() async {
    downloadPath = await getDownloadDirectoryPath();
    checkFile = File('$downloadPath/${materi.lampiran}');
    if (await checkFile.exists()) {
      setState(() {
        isDownloaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Materi Detail')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            materi.namaMateri,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(materi.jenisMateri),
          const Divider(),
          Html(data: materi.isi),
          const Divider(),
          const SizedBox(height: 16),
          const Text('Lampiran:'),
          const SizedBox(height: 6),
          Visibility(
            visible: materi.lampiran != '' &&
                [
                      '<p>You did not select a file to upload.</p>',
                      '<p>The upload path does not appear to be valid.</p>'
                    ].contains(materi.lampiran) !=
                    true,
            child: TextButton.icon(
              onPressed: () async {
                /// define the download task (subset of parameters shown)
                final task = DownloadTask(
                    url:
                        '${c.Config.baseUrlOffice}/assets/materi/${materi.lampiran}',
                    filename: materi.lampiran,
                    directory: 'materi',
                    baseDirectory: BaseDirectory.temporary,
                    updates: Updates.statusAndProgress);

                // Start download, and wait for result. Show progress and status changes
                // while downloading
                await FileDownloader()
                    .configureNotification(
                        running: const TaskNotification(
                            'Downloading', 'file: {filename}'),
                        progressBar: true)
                    .download(task, onProgress: (progress) {
                  if (!progress.isNegative && progress > 0) {
                    progress = progress * 100;
                    setState(() {
                      progressDownload = progress;
                    });
                  }
                }, onStatus: (status) async {
                  if (status == TaskStatus.complete) {
                    setState(() {
                      isDownloaded = true;
                    });

                    File(
                        '${(await getTemporaryDirectory()).path}/materi/${materi.lampiran}');

                    if (!await Directory(downloadPath).exists()) {
                      await Directory(downloadPath).create(recursive: true);
                    }

                    // await file.copy('$downloadPath/${materi.lampiran}');
                    // await file.delete();

                    if (true) {
                      try {
                        final res = await OpenFile.open(
                            '${(await getTemporaryDirectory()).path}/materi/${materi.lampiran}');

                        switch (res.type) {
                          case ResultType.noAppToOpen:
                            Get.snackbar(
                              "Perhatian",
                              "Tidak ada aplikasi untuk membuka file ini",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP,
                              margin: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              icon: const Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                              duration: const Duration(seconds: 2),
                            );
                            break;
                          case ResultType.fileNotFound:
                            Get.snackbar(
                              "Perhatian",
                              "File gagal didownload",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP,
                              margin: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              icon: const Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                              duration: const Duration(seconds: 2),
                            );
                            break;
                          case ResultType.error:
                            Get.snackbar(
                              "Perhatian",
                              "Terjadi kesalahan",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP,
                              margin: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              icon: const Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                              duration: const Duration(seconds: 2),
                            );
                            break;
                          case ResultType.permissionDenied:
                            Get.snackbar(
                              "Perhatian",
                              "Izin akses file ditolak, harap berikan akses!",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP,
                              margin: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              icon: const Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                              duration: const Duration(seconds: 2),
                            );
                            break;
                          case ResultType.done:
                            break;
                        }
                      } catch (e) {
                        Get.snackbar(
                          "Perhatian",
                          "Gagal mengakses file!",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          margin: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          icon: const Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          duration: const Duration(seconds: 2),
                        );
                      }
                      // } else {
                      //   Get.snackbar(
                      //     "Perhatian",
                      //     "Izin akses file ditolak, harap berikan akses!",
                      //     backgroundColor: Colors.red,
                      //     colorText: Colors.white,
                      //     snackPosition: SnackPosition.TOP,
                      //     margin: const EdgeInsets.symmetric(
                      //       vertical: 12,
                      //       horizontal: 16,
                      //     ),
                      //     icon: const Icon(
                      //       Icons.error,
                      //       color: Colors.white,
                      //     ),
                      //     duration: const Duration(seconds: 2),
                      //   );
                    }
                  } else if (status == TaskStatus.failed) {
                    setState(() {
                      progressDownload = 0;
                    });

                    Get.snackbar(
                      "Perhatian",
                      "Download Gagal",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.TOP,
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      icon: const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      duration: const Duration(seconds: 2),
                    );
                  } else if (status == TaskStatus.enqueued) {}
                });
              },
              icon: const Icon(Icons.download),
              label: const Text(
                'Download lampiran',
                textAlign: TextAlign.left,
              ),
            ),
          )
        ],
      ),
    );
  }
}
