import 'package:flutter/material.dart';
import 'package:h_honey/pages/controlSegumientoPage.dart';
import 'package:h_honey/pages/ejemplaresPage.dart';
import 'package:h_honey/pages/menu_page.dart';
import 'package:h_honey/pages/pagosPage.dart';
import 'package:h_honey/pages/sedesPage.dart';
import 'package:h_honey/pages/serviciosPage.dart';

class ClientesPage extends StatelessWidget {
  const ClientesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              //decoration: const BoxDecoration(color: Colors.amber),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 80,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'H-Honey',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Menú Principal'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Clientes'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ClientesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.miscellaneous_services),
              title: const Text('Servicios'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ServiciosPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categoría de Ejemplares'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const EjemplaresPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Pagos'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const PagosPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.house),
              title: const Text('Sedes'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SedesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.monitor_heart),
              title: const Text ('Control y Seguimiento'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ControlSeguimientoPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Página de Clientes'),
      ),
    );
  }
}
