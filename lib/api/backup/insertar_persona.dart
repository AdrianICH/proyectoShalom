import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<UserData>> insertarPersona(String usr, String email, String pssw,
    String name, String id, String tipo) async {
  var url = Uri.parse("http://localhost/shalom/api_insertar.php");
  final response = await http.post(url, body: {
    "usuario": usr,
    "correo": email,
    "pssw": pssw,
    "nombre": name,
    "id": id,
    "tipo": tipo
  });

  if (response.statusCode == 200) {
    if (response.body ==
        "Ha sucedido un error inexperado en la desconexion de la base de datos") {
      return [];
    }
    return compute(pasaraListapqrs, response.body);
  } else {
    throw Exception('Failed to create album.');
  }
}

List<UserData> pasaraListapqrs(String respuestaBody) {
  final pasar = json.decode(respuestaBody).cast<Map<String, dynamic>>();

  return pasar.map<UserData>((json) => UserData.fromJson(json)).toList();
}

class UserData {
  final IDUSUARIO;
  final USUARIO;
  final CORREO;
  final NOMBRE;
  final IDENTIFICACION;
  final TIPO;

  UserData(
      {this.IDUSUARIO,
      this.USUARIO,
      this.CORREO,
      this.NOMBRE,
      this.IDENTIFICACION,
      this.TIPO});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        IDUSUARIO: json['ID_USUARIO'],
        USUARIO: json['USUARIO'],
        CORREO: json['CORREO'],
        NOMBRE: json['NOMBRE'],
        IDENTIFICACION: json['IDENTIFICACION'],
        TIPO: json['ID_TIPO']);
  }
}
