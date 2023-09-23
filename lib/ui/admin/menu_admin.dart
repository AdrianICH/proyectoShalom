import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principal_shalom/api/consultar_usuarios.dart';
import 'package:principal_shalom/controllers/controlador_general.dart';
import 'package:principal_shalom/proceso/listado_usuarios_eliminar.dart';
import 'package:principal_shalom/proceso/listado_usuariosxtipo.dart';
import 'package:principal_shalom/proceso/new_userPage.dart';
import 'package:principal_shalom/ui/admin/principal_admin.dart';

class AdminMenu extends StatefulWidget {
  const AdminMenu({super.key});

  @override
  State<AdminMenu> createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  // Controlador
  ControlUsuarios control = Get.find();

  //Indice para paginas
  int _selectedIndex = 0;

  // Lista de paginas
  final List<Widget> _pages = [
    PPageAdmins(),
    NewUserForm(), ListadoUsuarios(),
    ListadoUsuariosEliminar() // Aquí debes definir tus páginas
  ];

  // Lista de nombres de paginas
  final List<String> _pageNames = [
    PPageAdmins().title,
    NewUserForm().title, ListadoUsuarios().title,
    ListadoUsuariosEliminar().title // Aquí debes definir tus páginas
  ];

  @override
  Widget build(BuildContext context) {
    final mainContext = context;

    return Scaffold(
      appBar: AppBar(
          title: Text(
        _pageNames[_selectedIndex],
        style: TextStyle(fontSize: 16),
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
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                setState(() {
                  _selectedIndex = 0; // o el índice de la página deseada
                });
                Navigator.pop(context); // Cierra el Drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Crear un nuevo usuario'),
              onTap: () {
                setState(() {
                  _selectedIndex = 1; // o el índice de la página deseada
                });
                Navigator.pop(context); // Cierra el Drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: Text('Listar todos los usuarios'),
              onTap: () {
                consultarUsuarios("!=3")
                    .then((respuesta) => control.guardarUsuario(respuesta));
                setState(() {
                  _selectedIndex = 2; // o el índice de la página deseada
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Listar estudiantes'),
              onTap: () {
                consultarUsuarios("=1")
                    .then((respuesta) => control.guardarUsuario(respuesta));
                setState(() {
                  _selectedIndex = 2; // o el índice de la página deseada
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Listar profesores'),
              onTap: () {
                consultarUsuarios("=2")
                    .then((respuesta) => control.guardarUsuario(respuesta));
                setState(() {
                  _selectedIndex = 2; // o el índice de la página deseada
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_forever),
              title: Text('Eliminar Usuario'),
              onTap: () {
                consultarUsuarios("!=3")
                    .then((respuesta) => control.guardarUsuario(respuesta));
                setState(() {
                  _selectedIndex = 3; // o el índice de la página deseada
                });
                Navigator.pop(context);
              },
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
