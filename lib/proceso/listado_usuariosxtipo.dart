import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principal_shalom/api/consultar_usuarios.dart';
import 'package:principal_shalom/controllers/controlador_general.dart';

class ListadoUsuarios extends StatefulWidget {
  const ListadoUsuarios({super.key});

  @override
  State<ListadoUsuarios> createState() => _ListadoUsuariosState();
}

class _ListadoUsuariosState extends State<ListadoUsuarios> {
  // Controlador
  ControlUsuarios CC = Get.find();

  /*void ConsultaUsuariosAPI(BuildContext context, String tipo) {
    consultarUsuarios(tipo).then((respuesta) {
      CC.cargarUsuario(respuesta);
    });
    build(context);
  }*/

  @override
  Widget build(BuildContext context) {
    List tipo = ["Estudiante", "Profesor", "Administrador"];

    return Container(
      child: Obx(() => CC.datos!.isEmpty == false
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: CC.datos?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.green[100],
                          child: ListTile(
                              leading: Text(CC.datos![index].IDUSUARIO),
                              trailing: Text(CC.datos![index].IDENTIFICACION),
                              title: Text(CC.datos![index].NOMBRE),
                              subtitle: Text(
                                  "Tipo: ${tipo[int.parse(CC.datos![index].TIPO) - 1]}")),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : Container(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            ))),
    );
  }
}
