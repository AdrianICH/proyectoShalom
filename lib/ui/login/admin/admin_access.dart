import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:principal_shalom/api/consulta_usuario.dart';
import 'package:principal_shalom/api/nuevo_acceso.dart';
import 'package:principal_shalom/controllers/controlador_general.dart';
import 'package:principal_shalom/proceso/new_user.dart';

// Comunicación con el controlador general
ControlUsuarios control = Get.find();
final _formKey = GlobalKey<FormState>();
// Controladores para los campo usuario y contrasena
TextEditingController userController = TextEditingController();
TextEditingController passwordController = TextEditingController();

void mostrarLoginAdmin(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text(
                'Necesita acceder como Administrador para crear un nuevo usuario'),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.only(top: 15.0),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(5),
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Form(
                  key: _formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.stretch, // Alineación horizontal
                      children: [
                        TextFormField(
                          controller: userController,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.person,
                              size: 30,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: "Usuario",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese usuario';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Campo para agregar la contrasena
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.key,
                              size: 30,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: "Contraseña",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese contraseña';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            // Boton Acceder y sus acciones
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  consultaUsuario(userController.text,
                                          passwordController.text)
                                      .then((respuesta) {
                                    if (respuesta.isEmpty) {
                                      // Si la respuesta es una lista vacía,
                                      // significa que el usuario no existe o la contrasena está mal
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Usuario y/o contrasena incorrectos'),
                                        ),
                                      );
                                    } else {
                                      // Si no, significa que se ha iniciado sesion
                                      // y se mostrará la informacion personal del usuario
                                      control.cargarUsuario(respuesta);
                                      nuevoAcceso(
                                          control.consulta![0].IDUSUARIO,
                                          DateFormat.Hms()
                                              .format(DateTime.now()),
                                          DateFormat.yMd()
                                              .format(DateTime.now()),
                                          "3");
                                      if (control.consulta![0].TIPO == "3") {
                                        InsertarUsuario()
                                            .mostrarFormulario(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Usuario no Administrador'),
                                          ),
                                        );
                                        Navigator.pop(context);
                                      }
                                    }
                                  });
                                  // Se limpian los campos usuario y contrasena
                                  userController.clear();
                                  passwordController.clear();
                                } else {
                                  // Mensaje de aviso para que el usuario ingrese sus credenciales
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Por favor, ingrese las credenciales'),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                'Acceder',
                                style: TextStyle(fontSize: 15),
                              ),
                            )),
                      ],
                    ),
                  )),
            ),
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
