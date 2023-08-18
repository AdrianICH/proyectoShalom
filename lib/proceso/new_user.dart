import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principal_shalom/controllers/controlador_general.dart';
import '../api/insertar_persona.dart';

class InsertarUsuario {
  // Controladores para cada campo dentro del formulario
  final txtuser = TextEditingController();
  final txtpssw = TextEditingController();
  final txtname = TextEditingController();
  final txtid = TextEditingController();
  final txttipo = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void mostrarFormulario(BuildContext context) {
    txttipo.text = "1";
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext c2) {
          return Column(children: [
            AppBar(
              title: Text("Regresar"),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Center(
                    // Un aviso o advertencia de que el nuevo usuario será de tipo 'Estudiante'
                    child: ListTile(
                      tileColor: Colors.green[50],
                      leading: Icon(Icons.warning),
                      title: Center(
                        child: Text("AVISO"),
                      ),
                      subtitle: Center(
                        child:
                            Text("El Nuevo Usuario será de tipo 'Estudiante'"),
                      ),
                      trailing: Icon(Icons.warning),
                    ),
                  ),
                  Form(
                      key: _formKey,
                      child: Column(children: [
                        // Campo de Usuario
                        TextFormField(
                          maxLength: 50,
                          controller: txtuser,
                          decoration: InputDecoration(
                              hintText: "Usuario",
                              labelText: "Nombre de Usuario"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese nombre de usuario';
                            }
                            return null;
                          },
                        ),
                        // Campo de contrasena
                        TextFormField(
                          obscureText: true,
                          maxLength: 20,
                          controller: txtpssw,
                          decoration: InputDecoration(
                              hintText: "123ABC", labelText: "Contrasena"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese contrasena';
                            }
                            return null;
                          },
                        ),
                        // Campo de Nombre
                        TextFormField(
                          maxLength: 50,
                          controller: txtname,
                          decoration: InputDecoration(
                              hintText: "NOMBRE APELLIDO", labelText: "Nombre"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese nombre';
                            }
                            return null;
                          },
                        ),
                        // Campo de la Cedula de Ciudadania
                        TextFormField(
                          maxLength: 15,
                          controller: txtid,
                          decoration: InputDecoration(
                              hintText: "0 000 000 000", labelText: "CC"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese cedula de ciudadania';
                            }
                            return null;
                          },
                        ),
                        Divider(),
                        // Boton que envía los datos a la API y luego a la base de datos
                        ElevatedButton.icon(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                insertarPersona(txtuser.text, txtpssw.text,
                                        txtname.text, txtid.text, txttipo.text)
                                    .then((respuesta) {
                                  ControlUsuarios CC = Get.find();
                                  CC.guardarUsuario(respuesta);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Text('Usuario agregado'),
                                            content: Text(
                                                "El usuario '${CC.datos![0].USUARIO}' se ha agregado satisfactoriamente."),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cerrar'),
                                              ),
                                            ]);
                                      });
                                });
                                Navigator.pop(context);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: Text('AVISO!'),
                                          content: Text(
                                              'El usuario no se ha podido agregar.'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Cerrar'),
                                            ),
                                          ]);
                                    });
                              }
                            },
                            icon: Icon(Icons.send),
                            label: Text("Registrar"))
                      ]))
                ])),
          ]);
        });
  }
}
