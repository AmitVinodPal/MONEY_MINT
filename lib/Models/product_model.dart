// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  String id;
  String name;
  var sp;
  String cp;
  String hsn;

  Products({
    required this.id,
    required this.name,
    required this.sp,
    required this.cp,
    required this.hsn,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        name: json["name"],
        sp: json["sp"],
        cp: json["cp"],
        hsn: json["hsn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sp": sp,
        "cp": cp,
        "hsn": hsn,
      };
}
