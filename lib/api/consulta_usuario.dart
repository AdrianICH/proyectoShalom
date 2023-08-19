import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<UserLoggedInfo>> consultaUsuario(String usr, String pssw) async {
  var url = Uri.parse("http://localhost/shalom/api_consultaUser.php");
  final response = await http.post(url, body: {"usuario": usr, "pssw": pssw});

  if (response.statusCode == 200) {
    return compute(pasaraListapqrs, response.body);
  } else {
    throw Exception('Failed to create album.');
  }
}

List<UserLoggedInfo> pasaraListapqrs(String respuestaBody) {
  final pasar = json.decode(respuestaBody).cast<Map<String, dynamic>>();

  return pasar
      .map<UserLoggedInfo>((json) => UserLoggedInfo.fromJson(json))
      .toList();
}

class UserLoggedInfo {
  final IDUSUARIO;
  final USUARIO;
  final NOMBRE;
  final IDENTIFICACION;
  final TIPO;

  UserLoggedInfo(
      {this.IDUSUARIO,
      this.USUARIO,
      this.NOMBRE,
      this.IDENTIFICACION,
      this.TIPO});

  factory UserLoggedInfo.fromJson(Map<String, dynamic> json) {
    return UserLoggedInfo(
        IDUSUARIO: json['ID_USUARIO'],
        USUARIO: json['USUARIO'],
        NOMBRE: json['NOMBRE'],
        IDENTIFICACION: json['IDENTIFICACION'],
        TIPO: json['ID_TIPO']);
  }
}
