import 'dart:convert';

UsersDataResponse usersDataResponseFromJson(String str) =>
    UsersDataResponse.fromJson(json.decode(str));

String usersDataResponseToJson(UsersDataResponse data) =>
    json.encode(data.toJson());

class UsersDataResponse {
  String? status;
  List<UsersData> data;
  String? msg;

  UsersDataResponse({
    this.status,
    required this.data,
    this.msg,
  });

  factory UsersDataResponse.fromJson(Map<String, dynamic> json) =>
      UsersDataResponse(
        status: json["status"] ?? "",
        data: List<UsersData>.from(
            json["data"].map((x) => UsersData.fromJson(x))),
        msg: json["msg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "msg": msg,
      };
}

class UsersData {
  String? id;
  String? name;
  String? email;

  UsersData({
    this.id,
    this.name,
    this.email,
  });

  factory UsersData.fromJson(Map<String, dynamic> json) {
    String firstName = json["first_name"] ?? "";
    String lastName = json["last_name"] ?? "";
    String fullName = "$firstName $lastName"
        .trim(); // Gabungkan first_name dan last_name, hilangkan spasi yang tidak diinginkan

    return UsersData(
      id: json["id"] ?? "",
      name: fullName,
      email: json["email"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}
