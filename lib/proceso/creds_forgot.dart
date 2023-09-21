import 'package:flutter/material.dart';
import 'package:principal_shalom/api/existe_usuarioCorreo.dart';

final emailController = TextEditingController();
final _formKey = GlobalKey<FormState>();

void mostrarCredsOlvidadas(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(10.0),
        title: Row(
          children: [
            Icon(Icons.email, color: Colors.blueAccent),
            SizedBox(width: 8.0),
            Text("Solicitud de Cambio",
                style: TextStyle(color: Colors.blueAccent)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Form(
              key: _formKey,
              child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: "Ingrese su correo electrónico"),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains("@")) {
                      return 'Ingrese correo valido';
                    }
                    return null;
                  }),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el dialogo
            },
            child: Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                consultaUserEmail(emailController.text).then((respuesta) {
                  if (respuesta.isEmpty) {
                    // Si la respuesta es una lista vacía,
                    // significa que el usuario no existe o el email está mal
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No existe usuario asociado a ese Email'),
                      ),
                    );
                  } else {
                    // Si no, significa que sí
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Solicitud enviada exitosamente'),
                      ),
                    );
                    Navigator.of(context).pop(); // Cierra el dialogo
                  }
                });
                // Se limpia el campo
                emailController.clear();
              }
            },
            child: Text("Enviar"),
          ),
        ],
      );
    },
  );
}
