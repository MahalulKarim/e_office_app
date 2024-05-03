// To parse this JSON data, do
//
//     final hasilJelajahResponse = hasilJelajahResponseFromJson(jsonString);

import 'dart:convert';

HasilJelajahResponse hasilJelajahResponseFromJson(String str) => HasilJelajahResponse.fromJson(json.decode(str));

String hasilJelajahResponseToJson(HasilJelajahResponse data) => json.encode(data.toJson());

List<HasilJelajah> hasilJelajahFromJson(List<dynamic> data) =>
    List<HasilJelajah>.from(data.map((x) => HasilJelajah.fromJson(x)));

class HasilJelajahResponse {
    String? status;
    List<HasilJelajah>? data;
    String? msg;

    HasilJelajahResponse({
        this.status,
        this.data,
        this.msg,
    });

    factory HasilJelajahResponse.fromJson(Map<String, dynamic> json) => HasilJelajahResponse(
        status: json["status"],
        data: json["data"] == null ? [] : List<HasilJelajah>.from(json["data"]!.map((x) => HasilJelajah.fromJson(x))),
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
    };
}

class HasilJelajah {
    String? id;
    String? idUser;
    String? tgl;
    String? foto;
    String? ket;
    String? lat;
    String? lang;
    String? idTugasDetailJelajah;
    String? tujuan;
    String? namaTugas;
    String? namaPegawai;
    String? asal;

    HasilJelajah({
        this.id,
        this.idUser,
        this.tgl,
        this.foto,
        this.ket,
        this.lat,
        this.lang,
        this.idTugasDetailJelajah,
        this.tujuan,
        this.namaTugas,
        this.namaPegawai,
        this.asal,
    });

    factory HasilJelajah.fromJson(Map<String, dynamic> json) => HasilJelajah(
        id: json["id"],
        idUser: json["id_user"],
        tgl: json["tgl"],
        foto: json["foto"],
        ket: json["ket"],
        lat: json["lat"],
        lang: json["lang"],
        idTugasDetailJelajah: json["id_tugas_detail_jelajah"],
        tujuan: json["tujuan"],
        namaTugas: json["nama_tugas"],
        namaPegawai: json["nama_pegawai"],
        asal: json["asal"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "tgl": tgl,
        "foto": foto,
        "ket": ket,
        "lat": lat,
        "lang": lang,
        "id_tugas_detail_jelajah": idTugasDetailJelajah,
        "tujuan": tujuan,
        "nama_tugas": namaTugas,
        "nama_pegawai": namaPegawai,
        "asal": asal,
    };
}
