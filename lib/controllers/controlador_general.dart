import 'package:principal_shalom/api/insertar_persona.dart';
import 'package:get/get.dart';
import '../api/consulta_usuario.dart';

class ControlPersonas extends GetxController {
  final Rxn<List<usuario>> _datos = Rxn<List<usuario>>();

  void guardarUsuario(List<usuario> X) {
    _datos.value = X;
  }

  List<usuario>? get datos => _datos.value;

  //Iniciar Sesion datos
  final Rxn<List<usuario2>> _consulta = Rxn<List<usuario2>>();

  void cargarUsuario(List<usuario2> X) {
    _consulta.value = X;
  }

  List<usuario2>? get consulta => _consulta.value;
}
