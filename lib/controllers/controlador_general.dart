import 'package:principal_shalom/api/consulta_tipos.dart';
import 'package:principal_shalom/api/insertar_persona.dart';
import 'package:get/get.dart';
import '../api/consulta_usuario.dart';

class ControlUsuarios extends GetxController {
  //Registrar Nuevo Usuario datos
  final Rxn<List<Usuario>> _datos = Rxn<List<Usuario>>();

  void guardarUsuario(List<Usuario> X) {
    _datos.value = X;
  }

  List<Usuario>? get datos => _datos.value;

  //Iniciar Sesion datos
  final Rxn<List<UserLoggedInfo>> _consulta = Rxn<List<UserLoggedInfo>>();

  void cargarUsuario(List<UserLoggedInfo> X) {
    _consulta.value = X;
  }

  List<UserLoggedInfo>? get consulta => _consulta.value;

  //Consulta de Tipos
  final Rxn<List<userTypes>> _types = Rxn<List<userTypes>>();

  void cargarTipos(List<userTypes> X) {
    _types.value = X;
  }

  List<userTypes>? get types => _types.value;
}
