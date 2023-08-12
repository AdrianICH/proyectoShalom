import 'package:flutter/material.dart';
import 'loginForm.dart';

class LoginBox extends StatefulWidget {
  const LoginBox({super.key});

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
              // Aca se construye la estructura que contendrá a los formularios del login
              width: MediaQuery.of(context).size.width * 0.75,
              margin: const EdgeInsets.only(top: 50.0),
              padding: const EdgeInsets.only(top: 15.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(5),
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: LoginForm().formulario(context)),
          Positioned(
            // Esto define la posicion del texto "Acceda a su cuenta" dentro del container
            left: 20,
            top: 50,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  border:
                      Border(top: BorderSide(color: Colors.black, width: 2))),
              padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
              child: const Text(
                'Acceda a su cuenta',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
