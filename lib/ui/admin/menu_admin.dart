import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principal_shalom/controllers/controlador_general.dart';
import 'package:principal_shalom/proceso/new_userPage.dart';

class AdminMenu extends StatefulWidget {
  const AdminMenu({super.key});

  @override
  State<AdminMenu> createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  ControlUsuarios control = Get.find();
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    NewUserForm(), // Aquí debes definir tus páginas

    // ... Añade más páginas según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    final mainContext = context;

    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Bienvenido/a a Shalom, ${control.consulta![0].NOMBRE} 👍!",
        style: TextStyle(fontSize: 14),
      )),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú de Administrador',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Crear un nuevo usuario'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: Text('Listar todos los usuarios'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Listar estudiantes'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Listar profesores'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app), // Icono para salir
              title: Text('Salir'),
              onTap: () {
                Navigator.pop(mainContext);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          opacity: 0.5,
          image: AssetImage(
              "light-blue-background.jpg"), // Este es una imagen que sirve como background de la pagina
          fit: BoxFit.cover,
        )),
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
    );
  }
}
