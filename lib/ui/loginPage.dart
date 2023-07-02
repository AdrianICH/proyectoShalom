import 'package:flutter/material.dart';
import 'package:principal_shalom/ui/loginBox.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Principal Page Shalom',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyLoginPage(title: 'Home Page Shalom'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});
  final String title;
  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text("Menú"),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          opacity: 0.5,
          image: AssetImage("light-blue-background.jpg"),
          fit: BoxFit.cover,
        ) // Este es una imagen que sirve como background de la pagina
            ),
        child: SingleChildScrollView(
          // Agrega un SingleChildScrollView alrededor del Column
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset("header-logo-custom1.png"),
                  ) // Este es el logo de la pagina
                ],
              ),
              // Añado un divider o separador
              const Divider(color: Colors.black),
              loginBox(),
              const SizedBox(height: 30), // Espacio vertical adicional
              const Text(
                "Centro Educativo Shalom 2023\nTodos los derechos reservados",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ) // Texto de información adicional
            ],
          ),
        ),
      ),
    );
  }
}
