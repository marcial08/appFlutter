import 'dart:convert';

CreditoRechazado creditoRechazadoFromJson(String str) => CreditoRechazado.fromJson(json.decode(str));

String creditoRechazadoToJson(CreditoRechazado data) => json.encode(data.toJson());

class CreditoRechazado {
  CreditoRechazado({
    this.id,
    this.fechaSolicitud,
    this.creditoSolicitado,
    this.agencia,
    this.tipoPersona,
    this.genero,
    this.estadoSolicitado,
    this.fechaRechazo,
    this.fechaInicio,
    this.motivoRechazo,
    this.otroMotivoRechazo,
    this.usuario
  });

  String id;
  String fechaSolicitud;
  String creditoSolicitado;
  String agencia;
  String tipoPersona;
  String genero;
  String estadoSolicitado;
  String fechaRechazo;
  String fechaInicio;
  String motivoRechazo;
  String otroMotivoRechazo;
  String usuario;
  List<CreditoRechazado> toList = [];

  factory CreditoRechazado.fromJson(Map<String, dynamic> json) => CreditoRechazado(
    id: json["id"] is int ? json['id'].toString() : json['id'],
      fechaSolicitud: json["fecha_solicitud"],
    creditoSolicitado: json["credito_solicitado"],
      agencia: json["agencia"],
      tipoPersona: json["tipo_persona"],
      genero: json["genero"],
      estadoSolicitado: json["estado_solicitado"],
      fechaRechazo: json["fecha_rechazo"],
      fechaInicio: json["fecha_inicio"],
      motivoRechazo: json["motivo_rechazo"],
      otroMotivoRechazo: json["otro_motivo_rechazo"],
      usuario: json["usuario"],
  );

  CreditoRechazado.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      CreditoRechazado creditoList = CreditoRechazado.fromJson(item);
      toList.add(creditoList);
    });
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha_solicitud": fechaSolicitud,
    "credito_solicitado": creditoSolicitado,
    "agencia": agencia,
    "tipo_persona": tipoPersona,
    "genero": genero,
    "estado_solicitado": estadoSolicitado,
    "fecha_rechazo": fechaRechazo,
    "fecha_inicio": fechaInicio,
    "motivo_rechazo": motivoRechazo,
    "otro_motivo_rechazo": otroMotivoRechazo,
    "usuario": usuario,
  };
}
