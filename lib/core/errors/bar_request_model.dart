import 'dart:convert';

/// responseCode : 2
/// messageCode : "600050"

BadRequestData badRequestDataFromJson(String str) =>
    BadRequestData.fromJson(json.decode(str));
String badRequestDataToJson(BadRequestData data) => json.encode(data.toJson());

class BadRequestData {
  BadRequestData({
    this.responseCode,
    this.messageCode,
  });

  BadRequestData.fromJson(dynamic json) {
    responseCode = json['responseCode'];
    messageCode = json['messageCode'];
  }
  num? responseCode;
  String? messageCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['responseCode'] = responseCode;
    map['messageCode'] = messageCode;
    return map;
  }
}
