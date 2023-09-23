import 'package:flutter/material.dart';

class AcercaDePage extends StatelessWidget {
  const AcercaDePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de..."),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'logo_user.png'), // Reemplaza con la ruta de tu imagen
              ),
              SizedBox(height: 20),
              Text(
                "Sistema Administrativo de Calificaciones Shalom (S.A.C.S)",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Versión 1.0.0",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Text(
                "Desarrollado por Adrian I. Cuerva H.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Text(
                "Contacto:\n• Teléfono: (+57) 301 717 41 00\n• WhatsApp: (+57) 304 498 78 18\n• GitHub: https://github.com/AdrianICH",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
