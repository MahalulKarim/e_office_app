// To parse this JSON data, do
//
//     final listLaporanResponse = listLaporanResponseFromJson(jsonString);

import 'dart:convert';

ListLaporanResponse listLaporanResponseFromJson(String str) => ListLaporanResponse.fromJson(json.decode(str));

String listLaporanResponseToJson(ListLaporanResponse data) => json.encode(data.toJson());

List<ListLaporan> listLaporanFromJson(List<dynamic> data) =>
    List<ListLaporan>.from(data.map((x) => ListLaporan.fromJson(x)));

class ListLaporanResponse {
    String? status;
    Data? data;
    String? msg;

    ListLaporanResponse({
        this.status,
        this.data,
        this.msg,
    });

    factory ListLaporanResponse.fromJson(Map<String, dynamic> json) => ListLaporanResponse(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "msg": msg,
    };
}

class Data {
    String? page;
    int? totalRows;
    int? totalPage;
    List<ListLaporan>? items;

    Data({
        this.page,
        this.totalRows,
        this.totalPage,
        this.items,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json["page"],
        totalRows: json["total_rows"],
        totalPage: json["total_page"],
        items: json["items"] == null ? [] : List<ListLaporan>.from(json["items"]!.map((x) => ListLaporan.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "total_rows": totalRows,
        "total_page": totalPage,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class ListLaporan {
    String? id;
    String? idTugas;
    String? idPegawai;
    String? tgl;
    String? ket;
    String? file;
    String? waktu;
    String? kodeKelas;
    String? namaPegawai;

    ListLaporan({
        this.id,
        this.idTugas,
        this.idPegawai,
        this.tgl,
        this.ket,
        this.file,
        this.waktu,
        this.kodeKelas,
        this.namaPegawai,
    });

    factory ListLaporan.fromJson(Map<String, dynamic> json) => ListLaporan(
        id: json["id"],
        idTugas: json["id_tugas"],
        idPegawai: json["id_pegawai"],
        tgl: json["tgl"],
        ket: json["ket"],
        file: json["file"],
        waktu: json["waktu"],
        kodeKelas: json["kode_kelas"],
        namaPegawai: json["nama_pegawai"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_tugas": idTugas,
        "id_pegawai": idPegawai,
        "tgl": tgl,
        "ket": ket,
        "file": file,
        "waktu": waktu,
        "kode_kelas": kodeKelas,
        "nama_pegawai": namaPegawai,
    };
}
