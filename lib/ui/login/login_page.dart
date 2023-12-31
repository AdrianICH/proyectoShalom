import 'package:flutter/material.dart';
import 'package:principal_shalom/ui/admin/menu_admin.dart';
import 'package:principal_shalom/ui/login/login_box.dart';

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
      debugShowCheckedModeBanner: false,
      routes: {
        '': (context) => Login(),
        '/admin': (context) => AdminMenu(),
      },
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
        height: MediaQuery.of(context).size.height,
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
                  SizedBox(
                    // Contenedor dinamico que se adapta al tamaño de la pantalla
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        "header-logo-custom1.png",
                        alignment: Alignment.centerLeft,
                        // Ajusta el tamaño de la imagen para que quepa dentro de la `Row`
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  )
                ],
              ),
              // Añado un divider o separador
              const Divider(color: Colors.black),
              LoginBox(),
              const SizedBox(height: 30), // Espacio vertical adicional
              const Text(
                // Texto de información adicional
                "Centro Educativo Shalom 2023\nTodos los derechos reservados",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
