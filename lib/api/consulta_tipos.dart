import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<UserTypes>> consultaTipos() async {
  var url = Uri.parse("http://localhost/shalom/api_consultaTipos.php");
  final response = await http.post(url, body: {});

  if (response.statusCode == 200) {
    return compute(pasaraListapqrs, response.body);
  } else {
    throw Exception('Failed to create album.');
  }
}

List<UserTypes> pasaraListapqrs(String respuestaBody) {
  final pasar = json.decode(respuestaBody).cast<Map<String, dynamic>>();

  return pasar.map<UserTypes>((json) => UserTypes.fromJson(json)).toList();
}

class UserTypes {
  final IDTIPO;
  final NOMBRE;

  UserTypes({
    this.IDTIPO,
    this.NOMBRE,
  });

  factory UserTypes.fromJson(Map<String, dynamic> json) {
    return UserTypes(IDTIPO: json['ID_TIPO'], NOMBRE: json['NOMBRE']);
  }
}
