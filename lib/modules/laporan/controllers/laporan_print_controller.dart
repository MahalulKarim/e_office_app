import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:eofficeapp/common/models/laporan_response.dart';
import 'package:eofficeapp/common/shared/services/laporan_service.dart';
// ignore: depend_on_referenced_packages
import 'package:pdf/pdf.dart';
// ignore: depend_on_referenced_packages
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../common/models/laporan_total_response.dart';

class LaporanPrintController extends GetxController {
  LaporanPrintController({
    Key? key,
    required this.periodeDates,
  });

  final DateTimeRange periodeDates;

  final formatDate = DateFormat('yyyy-MM-dd');
  late LaporanService laporanService;

  final _loading = true.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  final _error = false.obs;
  bool get error => _error.value;
  set error(bool value) => _error.value = value;

  final _emptyData = false.obs;
  bool get emptyData => _emptyData.value;
  set emptyData(bool value) => _emptyData.value = value;

  final _loadingPrint = false.obs;
  bool get loadingPrint => _loadingPrint.value;
  set loadingPrint(bool value) => _loadingPrint.value = value;

  @override
  void onInit() async {
    Get.lazyPut(() => LaporanService());
    laporanService = Get.find<LaporanService>();
    processData();
    super.onInit();
  }

  Future<LaporanTotalResponse?> getData() async {
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    var idPegawai = await storage.read(key: 'id_pegawai');
    final response = await laporanService.getTotalByPeriode(
      idUser: idUser ?? "",
      idPegawai: idPegawai ?? "",
      startDate: formatDate.format(periodeDates.start),
      endDate: formatDate.format(periodeDates.end),
    );
    if (response == null) {
      return null;
    }
    return response;
  }

  Future<LaporanResponse?> getListData({
    required int page,
  }) async {
    const storage = FlutterSecureStorage();
    var idUser = await storage.read(key: 'id_user');
    var idPegawai = await storage.read(key: 'id_pegawai');
    final response = await laporanService.getListByPeriode(
      idUser: idUser ?? "",
      idPegawai: idPegawai ?? "",
      startDate: formatDate.format(periodeDates.start),
      endDate: formatDate.format(periodeDates.end),
      page: page,
      limit: 25,
      sort: 'asc',
    );
    if (response == null) {
      error = true;
      return null;
    }
    if (response.data!.data!.isEmpty) {
      emptyData = true;
      return null;
    }
    return response;
  }

  Future<void> processData() async {
    error = false;
    loading = true;
    final dataTotal = await getData();
    final data = await getListData(page: 1);
    loading = false;
    if (dataTotal == null) {
      return;
    }
    if (data == null) {
      return;
    }
    if (data.data!.data!.isEmpty) {
      return;
    }
    printLaporan(dataTotal.data ?? LaporanTotal(), data.data!);
  }

  Future<void> printLaporan(LaporanTotal dataTotal, Data data) async {
    loadingPrint = true;
    int totalPage = (data.totalPage ?? 1);
    final doc = pw.Document(
      theme: pw.ThemeData.withFont(
        base: await PdfGoogleFonts.robotoRegular(),
        bold: await PdfGoogleFonts.robotoBold(),
        italic: await PdfGoogleFonts.robotoItalic(),
        boldItalic: await PdfGoogleFonts.robotoBoldItalic(),
      ),
    );
    await addPage(doc, dataTotal, data);
    if (totalPage > 1) {
      for (int i = 0; i < totalPage - 1; i++) {
        final newData = await getListData(page: i + 2);
        if (newData == null) {
          return;
        }
        await addPage(doc, dataTotal, newData.data!);
      }
    }
    await Printing.layoutPdf(
      format: PdfPageFormat.a4,
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
    loadingPrint = false;
  }

  Future<void> addPage(
      pw.Document doc, LaporanTotal dataTotal, Data data) async {
    const storage = FlutterSecureStorage();
    var username = await storage.read(key: 'username');
    int page = (data.page ?? 0);
    int limit = (data.limit ?? 0);
    int startNo = (page * limit) - limit;
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text(
                  "LAPORAN PRESENSI DAN TUGAS",
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  "Periode: ${DateFormat('dd MMMM yyyy').format(periodeDates.start)} - ${DateFormat('dd MMMM yyyy').format(periodeDates.end)}",
                  style: const pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  "Dicetak pada: ${data.now ?? ""}",
                  style: const pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  (username ?? ""),
                  style: const pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.SizedBox(
                  height: 16,
                ),
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.black),
                  columnWidths: const {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(8),
                    2: pw.FlexColumnWidth(3),
                    4: pw.FlexColumnWidth(3),
                    5: pw.FlexColumnWidth(3),
                    6: pw.FlexColumnWidth(3),
                    7: pw.FlexColumnWidth(3),
                    8: pw.FlexColumnWidth(3),
                  },
                  children: [
                    pw.TableRow(
                      verticalAlignment: pw.TableCellVerticalAlignment.middle,
                      children: [
                        pw.Text(
                          'No.',
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          'Tanggal',
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          'Masuk',
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          'Pulang',
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          'Status',
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          'Tugas\npagi',
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          'Tugas\nsiang',
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          'Tugas\ntanggungan',
                          textAlign: pw.TextAlign.center,
                        ),
                      ],
                    ),
                    ...data.data!.map((e) {
                      startNo++;
                      return pw.TableRow(
                        decoration: pw.BoxDecoration(
                          color: e.isHoliday == 1
                              ? PdfColors.black
                              : (e.dateIsLess == 1 && e.status == 0)
                                  ? PdfColors.red
                                  : e.statusTidakMasuk! > 0 &&
                                          e.statusTidakMasuk! < 4
                                      ? PdfColors.yellow
                                      : PdfColors.white,
                        ),
                        children: [
                          pw.Text(
                            "$startNo.",
                            style: pw.TextStyle(
                              color: e.isHoliday == 1 ||
                                      (e.dateIsLess == 1 && e.status == 0)
                                  ? PdfColors.white
                                  : PdfColors.black,
                            ),
                          ),
                          pw.Text(
                            '${e.textDay != null ? e.textDay!.substring(0, 3) : ""}, ${e.day ?? ""} ${e.textMonth != null ? e.textMonth!.substring(0, 3) : ""} ${e.year ?? ""}',
                            style: pw.TextStyle(
                              color: e.isHoliday == 1 ||
                                      (e.dateIsLess == 1 && e.status == 0)
                                  ? PdfColors.white
                                  : PdfColors.black,
                            ),
                          ),
                          pw.Text(
                            e.jamMasuk ?? "",
                            style: pw.TextStyle(
                              color: e.isHoliday == 1 ||
                                      (e.dateIsLess == 1 && e.status == 0)
                                  ? PdfColors.white
                                  : PdfColors.black,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            e.jamPulang ?? "",
                            style: pw.TextStyle(
                              color: e.isHoliday == 1 ||
                                      (e.dateIsLess == 1 && e.status == 0)
                                  ? PdfColors.white
                                  : PdfColors.black,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            e.statusTidakMasuk == 1
                                ? "Izin"
                                : e.statusTidakMasuk == 2
                                    ? "Sakit"
                                    : e.statusTidakMasuk == 3
                                        ? "Alpha"
                                        : e.statusTidakMasuk == 4
                                            ? "WFH"
                                            : "",
                            style: pw.TextStyle(
                              color: e.isHoliday == 1 ||
                                      (e.dateIsLess == 1 && e.status == 0)
                                  ? PdfColors.white
                                  : PdfColors.black,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 2,
                            ),
                            // decoration: const pw.BoxDecoration(
                            //   border: pw.Border(
                            //     bottom: pw.BorderSide(
                            //       width: 1,
                            //       color: PdfColors.grey100,
                            //     ),
                            //   ),
                            // ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                ...(e.listUploadPagi ?? []).map((ePagi) {
                                  return pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          ePagi.judul ?? "",
                                          style: pw.TextStyle(
                                            fontSize: 7,
                                            color: e.isHoliday == 1 ||
                                                    (e.dateIsLess == 1 &&
                                                        e.status == 0)
                                                ? PdfColors.white
                                                : PdfColors.black,
                                          ),
                                          maxLines: 1,
                                        ),
                                        pw.Text(
                                          "(${ePagi.ket ?? ""})",
                                          style: pw.TextStyle(
                                            fontSize: 7,
                                            color: e.isHoliday == 1 ||
                                                    (e.dateIsLess == 1 &&
                                                        e.status == 0)
                                                ? PdfColors.white
                                                : PdfColors.black,
                                            fontStyle: pw.FontStyle.italic,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ]);
                                }).toList(),
                              ],
                            ),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 2,
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                ...(e.listUploadSiang ?? []).map((eSiang) {
                                  return pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          eSiang.judul ?? "",
                                          style: pw.TextStyle(
                                            fontSize: 7,
                                            color: e.isHoliday == 1 ||
                                                    (e.dateIsLess == 1 &&
                                                        e.status == 0)
                                                ? PdfColors.white
                                                : PdfColors.black,
                                          ),
                                          maxLines: 1,
                                        ),
                                        pw.Text(
                                          "(${eSiang.ket ?? ""})",
                                          style: pw.TextStyle(
                                            fontSize: 7,
                                            color: e.isHoliday == 1 ||
                                                    (e.dateIsLess == 1 &&
                                                        e.status == 0)
                                                ? PdfColors.white
                                                : PdfColors.black,
                                            fontStyle: pw.FontStyle.italic,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ]);
                                }).toList(),
                              ],
                            ),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 2,
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                ...(e.listUploadTanggungan ?? [])
                                    .map((eTanggungan) {
                                  return pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          eTanggungan.judul ?? "",
                                          style: pw.TextStyle(
                                            fontSize: 7,
                                            color: e.isHoliday == 1 ||
                                                    (e.dateIsLess == 1 &&
                                                        e.status == 0)
                                                ? PdfColors.white
                                                : PdfColors.black,
                                          ),
                                          maxLines: 1,
                                        ),
                                        pw.Text(
                                          "(${eTanggungan.ket ?? ""})",
                                          style: pw.TextStyle(
                                            fontSize: 7,
                                            color: e.isHoliday == 1 ||
                                                    (e.dateIsLess == 1 &&
                                                        e.status == 0)
                                                ? PdfColors.white
                                                : PdfColors.black,
                                            fontStyle: pw.FontStyle.italic,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ]);
                                }).toList(),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
                pw.SizedBox(
                  height: 16,
                ),
                pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.TableBorder.all(color: PdfColors.black),
                  ),
                  child: pw.Center(
                    child: pw.Text(
                      'TOTAL',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.black),
                  // columnWidths: const {
                  //   0: pw.FlexColumnWidth(3),
                  //   1: pw.FlexColumnWidth(),
                  // },
                  children: [
                    pw.TableRow(
                      verticalAlignment: pw.TableCellVerticalAlignment.middle,
                      children: [
                        pw.Text(
                          'MASUK.',
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        pw.Text(
                          'PULANG',
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        pw.Text(
                          'IZIN',
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        pw.Text(
                          'SAKIT',
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        pw.Text(
                          'WFH',
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        pw.Text(
                          'TUGAS',
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      verticalAlignment: pw.TableCellVerticalAlignment.middle,
                      children: [
                        pw.Text(
                          dataTotal.totalMasuk.toString(),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          dataTotal.totalPulang.toString(),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          dataTotal.totalIzin.toString(),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          dataTotal.totalSakit.toString(),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          dataTotal.totalWfh.toString(),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          dataTotal.totalTugas.toString(),
                          textAlign: pw.TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
