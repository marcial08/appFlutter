import 'dart:convert';


User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {

  String id;
  String nombre;
  String email;
  String documentoIdentidad;
  String cargo;
  String oficina;
  String telefono;
  String usuario;
  String sessionToken;
  String roles;

  User({
    this.id,
    this.nombre,
    this.email,
    this.documentoIdentidad,
    this.cargo,
    this.oficina,
    this.telefono,
    this.usuario,
    this.sessionToken,
    this.roles
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      nombre: json["nombre"],
      email: json["email"],
      documentoIdentidad: json["documentoIdentidad"],
      cargo: json["cargo"],
      oficina: json["oficina"],
      telefono: json["telefono"],
      usuario: json["usuario"],
      sessionToken: json["session_token"],
      roles: json["roles"]
  );

  User.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      User user = User.fromJson(item);
     // toList.add(user);
    });
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "email": email,
    "documentoIdentidad": documentoIdentidad,
    "cargo": cargo,
    "oficina": oficina,
    "telefono": telefono,
    "usuario": usuario,
    "session_token": sessionToken,
    "roles": roles,
  };
}
