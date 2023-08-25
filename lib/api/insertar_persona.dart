import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Usuario>> insertarPersona(
    String usr, String pssw, String name, String id, String tipo) async {
  var url = Uri.parse("http://localhost/shalom/api_insertar.php");
  final response = await http.post(url, body: {
    "usuario": usr,
    "pssw": pssw,
    "nombre": name,
    "id": id,
    "tipo": tipo
  });

  if (response.statusCode == 200) {
    return compute(pasaraListapqrs, response.body);
  } else {
    throw Exception('Failed to create album.');
  }
}

List<Usuario> pasaraListapqrs(String respuestaBody) {
  final pasar = json.decode(respuestaBody).cast<Map<String, dynamic>>();

  return pasar.map<Usuario>((json) => Usuario.fromJson(json)).toList();
}

class Usuario {
  final IDUSUARIO;
  final USUARIO;
  final NOMBRE;
  final IDENTIFICACION;
  final TIPO;

  Usuario(
      {this.IDUSUARIO,
      this.USUARIO,
      this.NOMBRE,
      this.IDENTIFICACION,
      this.TIPO});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
        IDUSUARIO: json['ID_USUARIO'],
        USUARIO: json['USUARIO'],
        NOMBRE: json['NOMBRE'],
        IDENTIFICACION: json['IDENTIFICACION'],
        TIPO: json['ID_TIPO']);
  }
}
