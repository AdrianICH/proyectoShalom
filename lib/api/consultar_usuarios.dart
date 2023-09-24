import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:principal_shalom/api/insertar_persona.dart';

Future<List<UserData>> consultarUsuarios(String tipo) async {
  var url = Uri.parse("http://shalomaulas.eu5.org/my_apis/api_listarUsers.php");
  final response = await http.post(url, body: {"tp": tipo});

  if (response.statusCode == 200) {
    return compute(pasaraListapqrs, response.body);
  } else {
    throw Exception('Failed to create album.');
  }
}

List<UserData> pasaraListapqrs(String respuestaBody) {
  final pasar = json.decode(respuestaBody).cast<Map<String, dynamic>>();

  return pasar.map<UserData>((json) => UserData.fromJson(json)).toList();
}
