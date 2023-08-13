import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/controlador_general.dart';

class MostrarUsuario {
  ControlPersonas control = Get.find();

  void mostarDatosUsuario(BuildContext context) {
    String tipo;
    if (control.consulta![0].TIPO == "1") {
      tipo = "Estudiante";
    } else {
      tipo = "Profesor";
    }
    showModalBottomSheet(
        context: context,
        builder: (BuildContext c2) {
          return Column(
            children: [
              AppBar(
                title: Text("Bienvenido/a"),
              ),
              Center(
                // Texto de bienvenida
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Bienvenido/a a Shalom, ${tipo} - ${control.consulta![0].NOMBRE}!\nMira, eres tú 👇!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              Card(
                // Informacion personal organizada en forma de Card y ListTile
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      tileColor: Colors.green[50],
                      leading: Text(control.consulta![0].USUARIO),
                      trailing: Icon(Icons.person),
                      subtitle: Text(control.consulta![0].IDENTIFICACION),
                      title: Text(
                        control.consulta![0].NOMBRE,
                      )),
                ),
              ),
            ],
          );
        });
  }
}
