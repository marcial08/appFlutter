import 'dart:convert';

ResponseApi responseApiFromJson(String str) => ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {

  String message;
  String error;
  bool estado;
  dynamic data;

  ResponseApi({
    this.message,
    this.error,
    this.estado,
  });

  ResponseApi.fromJson(Map<String, dynamic> json) {

    message = json["message"];
    error = json["error"];
    estado = json["estado"];

    try {
      data = json['data'];
    } catch(e) {
      print('Exception data $e');
    }

  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "estado": estado,
    "data": data,
  };
}
