import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<UserThatExists>> consultaUserEmail(String email) async {
  var url = Uri.parse("http://localhost/shalom/api_consultaUserByEmail.php");
  final response = await http.post(url, body: {"correo": email});

  if (response.statusCode == 200) {
    return compute(pasaraListapqrs, response.body);
  } else {
    throw Exception('Failed to create album.');
  }
}

List<UserThatExists> pasaraListapqrs(String respuestaBody) {
  final pasar = json.decode(respuestaBody).cast<Map<String, dynamic>>();

  return pasar
      .map<UserThatExists>((json) => UserThatExists.fromJson(json))
      .toList();
}

class UserThatExists {
  final USUARIO;

  UserThatExists({this.USUARIO});

  factory UserThatExists.fromJson(Map<String, dynamic> json) {
    return UserThatExists(USUARIO: json['USUARIO']);
  }
}
