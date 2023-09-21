import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principal_shalom/controllers/controlador_general.dart';
import '../api/insertar_persona.dart';

class InsertarUsuario {
  // Controladores para cada campo dentro del formulario
  final txtuser = TextEditingController();
  final txtpssw = TextEditingController();
  final txtname = TextEditingController();
  final txtemail = TextEditingController();
  final txtid = TextEditingController();
  final txttipo = TextEditingController();

  // Controlador
  ControlUsuarios CC = Get.find();

  // La Key para el formulario
  final _formKey = GlobalKey<FormState>();

  void mostrarFormulario(BuildContext context) {
    final mainContext = context; // Almacenar el contexto principal

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext c2) {
          return SingleChildScrollView(
            child: Column(children: [
              AppBar(
                title: const Text("Regresar"),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Center(
                      // Un aviso o advertencia de que el nuevo usuario será de tipo 'Estudiante'
                      child: ListTile(
                        tileColor: Colors.green[50],
                        leading: const Icon(Icons.warning),
                        title: const Center(
                          child: Text("AVISO"),
                        ),
                        subtitle: const Center(
                          child: Text(
                              "Para añadir un nuevo Administrador, contacte al administrador de la base de datos"),
                        ),
                        trailing: const Icon(Icons.warning),
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(children: [
                          // Campo de Usuario
                          TextFormField(
                            maxLength: 50,
                            controller: txtname,
                            decoration: const InputDecoration(
                                hintText: "NOMBRE APELLIDO",
                                labelText: "Nombre"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese nombre';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            maxLength: 50,
                            controller: txtuser,
                            decoration: const InputDecoration(
                                hintText: "Usuario",
                                labelText: "Nombre de Usuario"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese nombre de usuario';
                              }
                              return null;
                            },
                          ),
                          // Campo de usuario
                          TextFormField(
                            maxLength: 50,
                            controller: txtemail,
                            decoration: const InputDecoration(
                                hintText: "example@email.com",
                                labelText: "Correo electronico"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese un correo electronico';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            obscureText: true,
                            maxLength: 20,
                            controller: txtpssw,
                            decoration: const InputDecoration(
                                hintText: "123ABC", labelText: "Contrasena"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese contrasena';
                              }
                              return null;
                            },
                          ),
                          // Campo de contrasena
                          TextFormField(
                            maxLength: 15,
                            controller: txtid,
                            decoration: const InputDecoration(
                                hintText: "0 000 000 000", labelText: "CC"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese cedula de ciudadania';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            maxLength: 10,
                            controller: txttipo,
                            decoration: const InputDecoration(
                                hintText: "Estudiante / Profesor",
                                labelText: "Tipo"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese el tipo de usuario';
                              }
                              return null;
                            },
                          ),
                          const Divider(),
                          // Boton que envía los datos a la API y luego a la base de datos
                          ElevatedButton.icon(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                String tipoFinal =
                                    await CC.verificacion(txttipo.text);
                                insertarPersona(
                                        txtuser.text,
                                        txtemail.text,
                                        txtpssw.text,
                                        txtname.text,
                                        txtid.text,
                                        tipoFinal)
                                    .then((respuesta) {
                                  ControlUsuarios CC = Get.find();
                                  CC.guardarUsuario(respuesta);
                                  showDialog(
                                      context:
                                          mainContext, // Usar el contexto principal aquí
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title:
                                                const Text('Usuario agregado'),
                                            content: Text(
                                                "El usuario '${CC.datos![0].USUARIO}' se ha agregado satisfactoriamente."),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cerrar'),
                                              ),
                                            ]);
                                      });
                                });
                                if (mainContext.mounted) {
                                  Navigator.pop(mainContext);
                                }
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              } else {
                                showDialog(
                                    context:
                                        mainContext, // Usar el contexto principal aquí
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: const Text('AVISO!'),
                                          content: const Text(
                                              'El usuario no se ha podido agregar.'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cerrar'),
                                            ),
                                          ]);
                                    });
                              }
                            },
                            icon: const Icon(Icons.send),
                            label: const Text("Registrar"),
                          ),
                        ]))
                  ])),
            ]),
          );
        });
  }
}
