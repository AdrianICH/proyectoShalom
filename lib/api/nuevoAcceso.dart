import 'package:http/http.dart' as http;

void nuevoAcceso(String idUser, String hora, String fecha, String idEstado) async {
  var url = Uri.parse("http://localhost/shalom/api_nuevoAcceso.php");
  final response = await http.post(url,
      body: {"idUsr": idUser, "hora": hora, "fecha": fecha, "idEtd": idEstado});

  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to create album.');
  }
}
