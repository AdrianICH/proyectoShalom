import 'package:http/http.dart' as http;

Future<String> eliminarUser(String userForDelete) async {
  var url = Uri.parse("http://localhost/shalom/api_eliminarUser.php");
  final response = await http.post(url, body: {"usuario": userForDelete});

  if (response.statusCode == 200) {
    if (response.body == '[]') {
      return "El usuario no existe o ya ha sido eliminado";
    } else {
      return response.body;
    }
  } else {
    throw Exception('Failed to create album.');
  }
}
