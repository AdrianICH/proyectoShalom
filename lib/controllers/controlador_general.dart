import 'package:principal_shalom/api/consulta_tipos.dart';
import 'package:principal_shalom/api/insertar_persona.dart';
import 'package:get/get.dart';
import '../api/login_api.dart';

class ControlUsuarios extends GetxController {
  //Registrar Nuevo Usuario datos
  final Rxn<List<UserData>> _datos = Rxn<List<UserData>>();

  void guardarUsuario(List<UserData> X) {
    _datos.value = X;
  }

  List<UserData>? get datos => _datos.value;

  //Iniciar Sesion datos
  final Rxn<List<UserData>> _consulta = Rxn<List<UserData>>();

  void cargarUsuario(List<UserData> X) {
    _consulta.value = X;
  }

  List<UserData>? get consulta => _consulta.value;

  //Consulta de Tipos
  final Rxn<List<UserTypes>> _types = Rxn<List<UserTypes>>();

  void cargarTipos(List<UserTypes> X) {
    _types.value = X;
  }

  Future<String> verificacion(String formType) async {
    final respuesta = await consultaTipos();
    cargarTipos(respuesta);
    var tipo = "";
    for (var i = 0; i < types!.length; i++) {
      if (types![i].NOMBRE == formType || types![i].IDTIPO == formType) {
        tipo = (i + 1).toString();
        break;
      }
    }

    return tipo;
  }

  List<UserTypes>? get types => _types.value;
}
