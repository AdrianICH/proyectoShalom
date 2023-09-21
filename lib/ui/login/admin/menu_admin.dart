import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principal_shalom/controllers/controlador_general.dart';
import 'package:principal_shalom/proceso/new_user.dart';

class AdminMenu extends StatefulWidget {
  const AdminMenu({super.key});

  @override
  State<AdminMenu> createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  ControlUsuarios control = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Bienvenido/a a Shalom, ${control.consulta![0].NOMBRE} 👍!",
        style: TextStyle(fontSize: 14),
      )),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          opacity: 0.5,
          image: AssetImage(
              "light-blue-background.jpg"), // Este es una imagen que sirve como background de la pagina
          fit: BoxFit.cover,
        )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    InsertarUsuario().mostrarFormulario(context);
                  },
                  child: const Text(
                    'Crear un nuevo usuario',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
