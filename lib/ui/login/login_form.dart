import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:principal_shalom/api/consulta_usuario.dart';
import 'package:principal_shalom/api/nuevo_acceso.dart';
import 'package:principal_shalom/controllers/controlador_general.dart';
import 'package:principal_shalom/proceso/modal_bienvenida_usuario.dart';
import 'package:principal_shalom/ui/login/admin/admin_access.dart';

class LoginForm {
  // Comunicación con el controlador general
  ControlUsuarios control = Get.find();
  final _formKey = GlobalKey<FormState>();
  // Controladores para los campo usuario y contrasena
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget formulario(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Alineación horizontal
          children: [
            // Campo para ingresar el usuario
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
                    consultaUsuario(
                            userController.text, passwordController.text)
                        .then((respuesta) {
                      if (respuesta.isEmpty) {
                        // Si la respuesta es una lista vacía,
                        // significa que el usuario no existe o la contrasena está mal
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Usuario y/o contrasena incorrectos'),
                          ),
                        );
                      } else {
                        // Si no, significa que se ha iniciado sesion
                        // y se mostrará la informacion personal del usuario
                        control.cargarUsuario(respuesta);
                        nuevoAcceso(
                            control.consulta![0].IDUSUARIO,
                            DateFormat.Hms().format(DateTime.now()),
                            DateFormat.yMd().format(DateTime.now()),
                            "1");
                        MostrarBienvenida().mostarDatosUsuario(context);
                      }
                    });
                    // Se limpian los campos usuario y contrasena
                    userController.clear();
                    passwordController.clear();
                  } else {
                    // Mensaje de aviso para que el usuario ingrese sus credenciales
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor, ingrese las credenciales'),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Acceder',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              // Boton para crear un nuevo usuario
              child: ElevatedButton(
                onPressed: () {
                  mostrarLoginAdmin(context);
                },
                child: const Text(
                  'Ingresar como Administrador',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              // Texto interactivo que sirve como aviso
              child: InkWell(
                onTap: () {},
                child: const Text(
                  '¿Olvidó su nombre de usuario o contraseña?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Checkbox relacionado al inicio de sesion, no es interactivo
            const CheckboxListTile(
              value: true,
              onChanged: null,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text("Mantener la sesión abierta"),
            ),
          ],
        ),
      ),
    );
  }
}
