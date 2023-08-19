import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<userTypes>> consultaUsuario() async {
  var url = Uri.parse("http://localhost/shalom/api_consultaTipos.php");
  final response = await http.post(url, body: "");

  if (response.statusCode == 200) {
    return compute(pasaraListapqrs, response.body);
  } else {
    throw Exception('Failed to create album.');
  }
}

List<userTypes> pasaraListapqrs(String respuestaBody) {
  final pasar = json.decode(respuestaBody).cast<Map<String, dynamic>>();

  return pasar.map<userTypes>((json) => userTypes.fromJson(json)).toList();
}

class userTypes {
  final IDTIPO;
  final NOMBRE;

  userTypes({
    this.IDTIPO,
    this.NOMBRE,
  });

  factory userTypes.fromJson(Map<String, dynamic> json) {
    return userTypes(IDTIPO: json['ID_TIPO'], NOMBRE: json['NOMBRE']);
  }
}
