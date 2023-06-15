// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ModelClass welcomeFromJson(String str) => ModelClass.fromJson(json.decode(str));

String welcomeToJson(ModelClass data) => json.encode(data.toJson());

class ModelClass {
  List<Sender> the7204460288;

  ModelClass({
    required this.the7204460288,
  });

  factory ModelClass.fromJson(Map<String, dynamic> json) => ModelClass(
        the7204460288: List<Sender>.from(
            json["7204460288"].map((x) => Sender.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "7204460288": List<dynamic>.from(the7204460288.map((x) => x.toJson())),
      };
}

class Sender {
  String message;
  String timeStamp;

  Sender({
    required this.message,
    required this.timeStamp,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        message: json["message"],
        timeStamp: json["timeStamp"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "timeStamp": timeStamp,
      };
}
