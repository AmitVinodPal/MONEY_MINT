// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

Users userFromJson(String str) => Users.fromJson(json.decode(str));

String userToJson(Users data) => json.encode(data.toJson());

class Users {
  String id;
  String name;
  String address;
  String email;
  String number;
  String panCard;
  String gstNumber;

  Users({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.number,
    required this.panCard,
    required this.gstNumber,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"] ?? " ",
        name: json["Name"],
        address: json["Address"],
        email: json["Email"],
        number: json["Number"],
        panCard: json["Pan-Card"],
        gstNumber: json["Gst-Number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "Address": address,
        "Email": email,
        "Number": number,
        "Pan-Card": panCard,
        "Gst-Number": gstNumber,
      };
}
