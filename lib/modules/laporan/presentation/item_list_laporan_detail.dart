import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/models/laporan_response.dart';
import 'package:eofficeapp/common/themes/styles.dart';

import '../../tugas/presentation/tugas_detail_page.dart';

class ItemListLaporanDetail extends StatelessWidget {
  const ItemListLaporanDetail({
    Key? key,
    required this.item,
  }) : super(key: key);

  final TugasSimple item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        item.isHoliday == 0
            ? const SizedBox()
            : Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                margin: const EdgeInsets.only(
                  bottom: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.flag_circle,
                      size: 18,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      item.holidayDescription != null &&
                              item.holidayDescription != ""
                          ? item.holidayDescription!
                          : "LIBUR",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
              ),
        if (item.statusTidakMasuk! > 0)
          Row(
            children: [
              item.isWfh == 0
                  ? const SizedBox()
                  : Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      margin: const EdgeInsets.only(
                        bottom: 6,
                        right: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.home_work_outlined,
                            size: 15,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "WFH",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    ),
              item.statusTidakMasuk! > 0 && item.statusTidakMasuk! < 4
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      margin: const EdgeInsets.only(
                        bottom: 6,
                      ),
                      decoration: BoxDecoration(
                        color: item.statusTidakMasuk == 1
                            ? Colors.yellow
                            : item.statusTidakMasuk == 2
                                ? Colors.red
                                : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.statusTidakMasuk == 1
                                ? Icons.time_to_leave_outlined
                                : item.statusTidakMasuk == 2
                                    ? Icons.sick_outlined
                                    : item.statusTidakMasuk == 3
                                        ? Icons.close_rounded
                                        : Icons.free_breakfast,
                            size: 15,
                            color: item.statusTidakMasuk == 1
                                ? Colors.black
                                : item.statusTidakMasuk == 2
                                    ? Colors.white
                                    : Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            item.statusTidakMasuk == 1
                                ? "Izin"
                                : item.statusTidakMasuk == 2
                                    ? "Sakit"
                                    : item.statusTidakMasuk == 3
                                        ? "Alpha"
                                        : "-",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: item.statusTidakMasuk == 1
                                  ? Colors.black
                                  : item.statusTidakMasuk == 2
                                      ? Colors.white
                                      : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        item.isHoliday == 0 &&
                item.status != 1 &&
                item.status != 2 &&
                item.statusTidakMasuk == 0
            ? item.dateIsNow == 1 || item.dateIsLess == 1
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.only(
                      bottom: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.dateIsNow == 1
                          ? "BELUM PRESENSI"
                          : "TIDAK DIANGGAP MASUK",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: item.dateIsNow == 1 ? Colors.black : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox()
            : IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (item.status == 1 || item.status == 2)
                        ? Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: mainColor.shade900,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.alarm,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Masuk${item.isWfh == 1 ? " WFH" : ""}",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    item.jamMasuk ?? "",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    item.status == 2
                        ? VerticalDivider(
                            width: 7,
                            color: item.isHoliday == 1
                                ? Colors.red.shade100
                                : null,
                          )
                        : const SizedBox(),
                    item.status == 2
                        ? Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.alarm,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Pulang${item.isWfh == 1 ? " WFH" : ""}",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    item.jamPulang ?? "",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
        if ((item.listUploadPagi != null && item.listUploadPagi!.isNotEmpty) ||
            (item.listUploadSiang != null &&
                item.listUploadSiang!.isNotEmpty) ||
            (item.listUploadTanggungan != null &&
                item.listUploadTanggungan!.isNotEmpty))
          Divider(
            thickness: 1,
            height: 12,
            color: item.isHoliday == 1 ? Colors.red.shade100 : null,
          ),
        if ((item.listUploadPagi != null && item.listUploadPagi!.isNotEmpty) ||
            (item.listUploadSiang != null &&
                item.listUploadSiang!.isNotEmpty) ||
            (item.listUploadTanggungan != null &&
                item.listUploadTanggungan!.isNotEmpty))
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (item.listUploadPagi != null && item.listUploadPagi!.isNotEmpty)
                  ? Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Tugas pagi",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  ...(item.listUploadPagi ?? []).map((ePagi) {
                                    return InkWell(
                                      onTap: () {
                                        Get.to(() => TugasDetailPage(
                                              type: 1,
                                              id: int.parse(ePagi.id ?? "0"),
                                              tgl: ePagi.tgl ?? "",
                                              title: ePagi.judul ?? "",
                                              subtitle: ePagi.tugas ?? "",
                                              ket: ePagi.ket ?? "",
                                              progress: ePagi.progress,
                                              urlPhoto:
                                                  (ePagi.urlFile != null &&
                                                          ePagi.urlFile != "")
                                                      ? ePagi.urlFile
                                                      : null,
                                            ));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 3),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 6,
                                        ),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // (ePagi.urlFile != null &&
                                            //         ePagi.urlFile != "")
                                            //     ? Container(
                                            //         margin:
                                            //             const EdgeInsets.only(
                                            //           right: 5,
                                            //         ),
                                            //         child: ClipRRect(
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   4),
                                            //           child: Container(
                                            //             width: 20,
                                            //             height: 20,
                                            //             color: Colors.white,
                                            //             child: Image.network(
                                            //               ePagi.urlFile ?? "",
                                            //               fit: BoxFit.cover,
                                            //               loadingBuilder:
                                            //                   (BuildContext
                                            //                           context,
                                            //                       Widget child,
                                            //                       ImageChunkEvent?
                                            //                           loadingProgress) {
                                            //                 if (loadingProgress ==
                                            //                     null) {
                                            //                   return child;
                                            //                 }
                                            //                 return Center(
                                            //                   child:
                                            //                       CircularProgressIndicator(
                                            //                     value: loadingProgress
                                            //                                 .expectedTotalBytes !=
                                            //                             null
                                            //                         ? loadingProgress
                                            //                                 .cumulativeBytesLoaded /
                                            //                             loadingProgress
                                            //                                 .expectedTotalBytes!
                                            //                         : null,
                                            //                   ),
                                            //                 );
                                            //               },
                                            //             ),
                                            //           ),
                                            //         ),
                                            //       )
                                            //     : const SizedBox(),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    ePagi.judul ?? "-",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    ePagi.ket ?? "-",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              (item.listUploadPagi != null &&
                          item.listUploadPagi!.isNotEmpty) &&
                      (item.listUploadSiang != null &&
                          item.listUploadSiang!.isNotEmpty)
                  ? VerticalDivider(
                      width: 7,
                      color: item.isHoliday == 1 ? Colors.red.shade100 : null,
                    )
                  : const SizedBox(),
              (item.listUploadSiang != null && item.listUploadSiang!.isNotEmpty)
                  ? Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade600,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Tugas siang",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  ...(item.listUploadSiang ?? []).map((eSiang) {
                                    return InkWell(
                                      onTap: () {
                                        Get.to(() => TugasDetailPage(
                                              type: 2,
                                              id: int.parse(eSiang.id ?? "0"),
                                              tgl: eSiang.tgl ?? "",
                                              title: eSiang.judul ?? "",
                                              subtitle: eSiang.tugas ?? "",
                                              ket: eSiang.ket ?? "",
                                              progress: eSiang.progress,
                                              urlPhoto:
                                                  (eSiang.urlFile != null &&
                                                          eSiang.urlFile != "")
                                                      ? eSiang.urlFile
                                                      : null,
                                            ));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 3),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 6,
                                        ),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // (eSiang.urlFile != null &&
                                            //         eSiang.urlFile != "")
                                            //     ? Container(
                                            //         margin:
                                            //             const EdgeInsets.only(
                                            //           right: 5,
                                            //         ),
                                            //         child: ClipRRect(
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   4),
                                            //           child: Container(
                                            //             width: 20,
                                            //             height: 20,
                                            //             color: Colors.white,
                                            //             child: Image.network(
                                            //               eSiang.urlFile ?? "",
                                            //               fit: BoxFit.cover,
                                            //               loadingBuilder:
                                            //                   (BuildContext
                                            //                           context,
                                            //                       Widget child,
                                            //                       ImageChunkEvent?
                                            //                           loadingProgress) {
                                            //                 if (loadingProgress ==
                                            //                     null) {
                                            //                   return child;
                                            //                 }
                                            //                 return Center(
                                            //                   child:
                                            //                       CircularProgressIndicator(
                                            //                     value: loadingProgress
                                            //                                 .expectedTotalBytes !=
                                            //                             null
                                            //                         ? loadingProgress
                                            //                                 .cumulativeBytesLoaded /
                                            //                             loadingProgress
                                            //                                 .expectedTotalBytes!
                                            //                         : null,
                                            //                   ),
                                            //                 );
                                            //               },
                                            //             ),
                                            //           ),
                                            //         ),
                                            //       )
                                            //     : const SizedBox(),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    eSiang.judul ?? "-",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    eSiang.ket ?? "-",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              ((item.listUploadPagi != null &&
                              item.listUploadPagi!.isNotEmpty) ||
                          (item.listUploadSiang != null &&
                              item.listUploadSiang!.isNotEmpty)) &&
                      (item.listUploadTanggungan != null &&
                          item.listUploadTanggungan!.isNotEmpty)
                  ? VerticalDivider(
                      width: 7,
                      color: item.isHoliday == 1 ? Colors.red.shade100 : null,
                    )
                  : const SizedBox(),
              (item.listUploadTanggungan != null &&
                      item.listUploadTanggungan!.isNotEmpty)
                  ? Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Tugas tanggungan",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  ...(item.listUploadTanggungan ?? [])
                                      .map((eTanggungan) {
                                    return InkWell(
                                      onTap: () {
                                        Get.to(() => TugasDetailPage(
                                              type: 3,
                                              id: int.parse(
                                                  eTanggungan.id ?? "0"),
                                              tgl: eTanggungan.tgl ?? "",
                                              title: eTanggungan.judul ?? "",
                                              subtitle: eTanggungan.tugas ?? "",
                                              ket: eTanggungan.ket ?? "",
                                              progress: eTanggungan.progress,
                                              urlPhoto: (eTanggungan.urlFile !=
                                                          null &&
                                                      eTanggungan.urlFile != "")
                                                  ? eTanggungan.urlFile
                                                  : null,
                                            ));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 3),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 6,
                                        ),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // (eTanggungan.urlFile != null &&
                                            //         eTanggungan.urlFile != "")
                                            //     ? Container(
                                            //         margin:
                                            //             const EdgeInsets.only(
                                            //           right: 5,
                                            //         ),
                                            //         child: ClipRRect(
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   4),
                                            //           child: Container(
                                            //             width: 20,
                                            //             height: 20,
                                            //             color: Colors.white,
                                            //             child: Image.network(
                                            //               eTanggungan.urlFile ??
                                            //                   "",
                                            //               fit: BoxFit.cover,
                                            //               loadingBuilder:
                                            //                   (BuildContext
                                            //                           context,
                                            //                       Widget child,
                                            //                       ImageChunkEvent?
                                            //                           loadingProgress) {
                                            //                 if (loadingProgress ==
                                            //                     null) {
                                            //                   return child;
                                            //                 }
                                            //                 return Center(
                                            //                   child:
                                            //                       CircularProgressIndicator(
                                            //                     value: loadingProgress
                                            //                                 .expectedTotalBytes !=
                                            //                             null
                                            //                         ? loadingProgress
                                            //                                 .cumulativeBytesLoaded /
                                            //                             loadingProgress
                                            //                                 .expectedTotalBytes!
                                            //                         : null,
                                            //                   ),
                                            //                 );
                                            //               },
                                            //             ),
                                            //           ),
                                            //         ),
                                            //       )
                                            //     : const SizedBox(),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    eTanggungan.judul ?? "-",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    eTanggungan.ket ?? "-",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
      ],
    );
  }
}
