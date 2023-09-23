import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principal_shalom/api/consultar_usuarios.dart';
import 'package:principal_shalom/api/eliminar_usuario.dart';
import 'package:principal_shalom/controllers/controlador_general.dart';

class ListadoUsuariosEliminar extends StatefulWidget {
  const ListadoUsuariosEliminar({super.key});

  @override
  State<ListadoUsuariosEliminar> createState() =>
      _ListadoUsuariosEliminarState();
}

class _ListadoUsuariosEliminarState extends State<ListadoUsuariosEliminar> {
  // Controladores
  ControlUsuarios CC = Get.find();

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
                          color: Colors.red[100],
                          child: ListTile(
                              onTap: () {
                                final userController = TextEditingController();
                                final _formKey = GlobalKey<FormState>();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.all(10.0),
                                      title: Row(
                                        children: [
                                          Icon(Icons.warning_amber,
                                              color: Colors.red),
                                          SizedBox(width: 8.0),
                                          Text("Confirmación requerida!",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Form(
                                            key: _formKey,
                                            child: TextFormField(
                                                controller: userController,
                                                decoration: InputDecoration(
                                                    labelText:
                                                        "Ingrese el nombre del usuario"),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Ingrese usuario';
                                                  }
                                                  if (value !=
                                                      CC.datos![index]
                                                          .USUARIO) {
                                                    return 'Usuario no coincide';
                                                  }
                                                  return null;
                                                }),
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Cierra el dialogo
                                          },
                                          child: Text("Cancelar"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              eliminarUser(userController.text)
                                                  .then((respuesta) {
                                                if (respuesta !=
                                                    "El usuario no existe o ya ha sido eliminado") {
                                                  // Si la respuesta es una lista vacía,
                                                  // significa que el usuario no existe o el usuario está mal
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'El usuario no coincide'),
                                                    ),
                                                  );
                                                } else {
                                                  // Si no, significa que sí
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'El usuario ${CC.datos![index].USUARIO} ha sido eliminado'),
                                                    ),
                                                  );
                                                  Navigator.of(context)
                                                      .pop(); // Cierra el dialogo
                                                  // Reiniciar la página
                                                  consultarUsuarios("!=3").then(
                                                      (respuesta) =>
                                                          CC.guardarUsuario(
                                                              respuesta));
                                                }
                                              });
                                              // Se limpia el campo
                                              userController.clear();
                                            }
                                          },
                                          child: Text("Confirmar"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              leading: Text(CC.datos![index].IDUSUARIO),
                              trailing: Text(CC.datos![index].IDENTIFICACION),
                              title: Text(
                                  "${CC.datos![index].NOMBRE} (${CC.datos![index].USUARIO})"),
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
