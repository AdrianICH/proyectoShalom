import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<usuario2>> consultaUsuario(String usr, String pssw) async {
  var url = Uri.parse("http://localhost/shalom/api_consultaUser.php");
  final response = await http.post(url, body: {"usuario": usr, "pssw": pssw});

  if (response.statusCode == 200) {
    return compute(pasaraListapqrs, response.body);
  } else {
    throw Exception('Failed to create album.');
  }
}

List<usuario2> pasaraListapqrs(String respuestaBody) {
  final pasar = json.decode(respuestaBody).cast<Map<String, dynamic>>();

  return pasar.map<usuario2>((json) => usuario2.fromJson(json)).toList();
}

class usuario2 {
  final IDUSUARIO;
  final USUARIO;
  final NOMBRE;
  final IDENTIFICACION;
  final TIPO;

  usuario2(
      {this.IDUSUARIO,
      this.USUARIO,
      this.NOMBRE,
      this.IDENTIFICACION,
      this.TIPO});

  factory usuario2.fromJson(Map<String, dynamic> json) {
    return usuario2(
        IDUSUARIO: json['ID_USUARIO'],
        USUARIO: json['USUARIO'],
        NOMBRE: json['NOMBRE'],
        IDENTIFICACION: json['IDENTIFICACION'],
        TIPO: json['ID_TIPO']);
  }
}
