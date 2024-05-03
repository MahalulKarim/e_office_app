// To parse this JSON data, do
//
//     final pesertaResponse = pesertaResponseFromJson(jsonString);

import 'dart:convert';

PesertaResponse pesertaResponseFromJson(Map<String, dynamic> data) =>
    PesertaResponse.fromJson(data);

String pesertaResponseToJson(PesertaResponse data) =>
    json.encode(data.toJson());

class PesertaResponse {
  Meta meta;
  List<Peserta> items;

  PesertaResponse({
    required this.meta,
    required this.items,
  });

  factory PesertaResponse.fromJson(Map<String, dynamic> json) =>
      PesertaResponse(
        meta: Meta.fromJson(json["meta"]),
        items:
            List<Peserta>.from(json["items"].map((x) => Peserta.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Peserta {
  String id;
  String idUsers;
  String namaPegawai;
  String asal;
  String tglMasuk;
  String tglSelesai;
  String rekening;
  String level;
  String tingkat;
  String gajiPokok;
  String idJabatan;
  String foto;
  String predikat;
  String lama;
  String idSertifikat;
  String subdistrictId;
  String alamat;
  String pendidikan;
  String jurusan;
  String keahlian;
  String kodeKelas;
  String tglLahir;
  String jenisKelamin;
  String statusPernikahan;

  Peserta({
    required this.id,
    required this.idUsers,
    required this.namaPegawai,
    required this.asal,
    required this.tglMasuk,
    required this.tglSelesai,
    required this.rekening,
    required this.level,
    required this.tingkat,
    required this.gajiPokok,
    required this.idJabatan,
    required this.foto,
    required this.predikat,
    required this.lama,
    required this.idSertifikat,
    required this.subdistrictId,
    required this.alamat,
    required this.pendidikan,
    required this.jurusan,
    required this.keahlian,
    required this.kodeKelas,
    required this.tglLahir,
    required this.jenisKelamin,
    required this.statusPernikahan,
  });

  factory Peserta.fromJson(Map<String, dynamic> json) => Peserta(
        id: json["id"],
        idUsers: json["id_users"],
        namaPegawai: json["nama_pegawai"],
        asal: json["asal"],
        tglMasuk: json["tgl_masuk"],
        tglSelesai: json["tgl_selesai"],
        rekening: json["rekening"],
        level: json["level"],
        tingkat: json["tingkat"],
        gajiPokok: json["gaji_pokok"],
        idJabatan: json["id_jabatan"],
        foto: json["foto"],
        predikat: json["predikat"],
        lama: json["lama"],
        idSertifikat: json["id_sertifikat"],
        subdistrictId: json["subdistrict_id"],
        alamat: json["alamat"],
        pendidikan: json["pendidikan"],
        jurusan: json["jurusan"],
        keahlian: json["keahlian"],
        kodeKelas: json["kode_kelas"],
        tglLahir: json["tgl_lahir"],
        jenisKelamin: json["jenis_kelamin"],
        statusPernikahan: json["status_pernikahan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_users": idUsers,
        "nama_pegawai": namaPegawai,
        "asal": asal,
        "tgl_masuk": tglMasuk,
        "tgl_selesai": tglSelesai,
        "rekening": rekening,
        "level": level,
        "tingkat": tingkat,
        "gaji_pokok": gajiPokok,
        "id_jabatan": idJabatan,
        "foto": foto,
        "predikat": predikat,
        "lama": lama,
        "id_sertifikat": idSertifikat,
        "subdistrict_id": subdistrictId,
        "alamat": alamat,
        "pendidikan": pendidikan,
        "jurusan": jurusan,
        "keahlian": keahlian,
        "kode_kelas": kodeKelas,
        "tgl_lahir": tglLahir,
        "jenis_kelamin": jenisKelamin,
        "status_pernikahan": statusPernikahan,
      };
}

class Meta {
  int currentPage;
  int perPage;
  int total;

  Meta({
    required this.currentPage,
    required this.perPage,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: int.parse(json["currentPage"].toString()),
        perPage: int.parse(json["perPage"].toString()),
        total: int.parse(json["total"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "perPage": perPage,
        "total": total,
      };
}
