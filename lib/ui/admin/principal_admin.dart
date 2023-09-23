import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principal_shalom/controllers/controlador_general.dart';

class PPageAdmins extends StatefulWidget {
  const PPageAdmins({super.key});
  final String title = "Inicio";

  @override
  State<PPageAdmins> createState() => _PPageAdminsState();
}

class _PPageAdminsState extends State<PPageAdmins> {
  // Controlador
  ControlUsuarios control = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                "Bienvenido, ${control.consulta![0].USUARIO}!",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons
                  .person), // Icono para representar el nombre del administrador
              title: Text("Nombre del Administrador"),
              subtitle: Text(control.consulta![0].NOMBRE),
            ),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(
                  Icons.email), // Icono para representar el correo electrónico
              title: Text("Correo Electrónico"),
              subtitle: Text(control.consulta![0].CORREO),
            ),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.work), // Icono para representar el cargo
              title: Text("Cargo"),
              subtitle: Text("Administrador"),
            ),
          ],
        ),
      ),
    );
  }
}
