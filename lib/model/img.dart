// To parse this JSON data, do
//
//     final ImageModel = ImageModelFromJson(jsonString);

import 'dart:convert';

List<ImageModel> imageModelFromJson(String str) =>
    List<ImageModel>.from(json.decode(str).map((x) => ImageModel.fromJson(x)));

String imageModelToJson(List<ImageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageModel {
  ImageModel({
    this.name,
    this.imgUrl,
  });

  String name;
  String imgUrl;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        name: json["name"],
        imgUrl: json["imgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imgUrl": imgUrl,
      };
}
