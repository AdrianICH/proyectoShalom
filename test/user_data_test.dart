import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:principal_shalom/api/consulta_tipos.dart';
import 'package:principal_shalom/api/consulta_usuario.dart';
import 'package:principal_shalom/api/eliminar_usuario.dart';
import 'package:principal_shalom/api/insertar_persona.dart';
import 'package:principal_shalom/controllers/controlador_general.dart';

void main() {
  test('Testeo de llamada usuario desde API y respuesta', () async {
    final respuesta = await consultaUsuario("Ambaru", "9091");

    expect(respuesta, isInstanceOf<List<UserLoggedInfo>>(),
        reason:
            "Verificar si la instancia devuelta es de tipo List<UserLoggedInfo>");
    expect(respuesta.isEmpty, false,
        reason: "Verificar si la respuesta contiene datos de usuario");
  });

  test('Testeo de llamada nombre de usuario desde API y controlador', () async {
    Get.put(ControlUsuarios());
    ControlUsuarios control = Get.find();
    final respuesta = await consultaUsuario("Ambaru", "9091");

    control.cargarUsuario(respuesta);
    expect(control.consulta?[0].NOMBRE, "Ambar Isbel",
        reason:
            "Verificar si los datos llamados del usuario son correctos/no están manipulados");
  });

  test('Testeo de llamada a los tipos de usuario desde API y controlador',
      () async {
    Get.put(ControlUsuarios());
    ControlUsuarios control = Get.find();
    final respuesta = await consultaTipos();
    control.cargarTipos(respuesta);
    expect(control.types, isInstanceOf<List<UserTypes>>(),
        reason:
            "Verificar si los datos llamados de los tipos de usuario son correctos/no están manipulados");

    var verificacionResult = await control.verificacion("Estudiante");
    expect(verificacionResult, "1",
        reason:
            "Verificar si los datos son correctos al llamar desde el formulario (Estudiante)");

    verificacionResult = await control.verificacion("Profesor");
    expect(verificacionResult, "2",
        reason:
            "Verificar si los datos son correctos al llamar desde el formulario (Profesor)");
  });

  test('Testeo de agregación de usuarios', () async {
    Get.put(ControlUsuarios());
    ControlUsuarios control = Get.find();
    var respuesta = await insertarPersona(
        "adriactor63",
        "adriancue204@gmail.com",
        "qscxzsewaxd",
        "Adrian Hernandez",
        "1114902470",
        "2");
    control.guardarUsuario(respuesta);
    if (control.datos!.isEmpty) {
      expect(control.datos, [],
          reason: "Si el usuario ya existía, la respuesta es esta");
    } else {
      expect(control.datos![0].USUARIO, "adriactor63",
          reason:
              "Verificar que el usuario ha sido agregado satisfactoriamente");
    }
  });

  test('Testeo de eliminacion de usuarios', () async {
    var sndRespuesta = await eliminarUser("adriactor63");
    if (sndRespuesta != "El usuario no existe o ya ha sido eliminado") {
      expect(sndRespuesta, "Se ha eliminado el usuario: adriactor63",
          reason:
              "Verificar el el usuario ha sido eliminado satisfactoriamente");
    }
  });
}
