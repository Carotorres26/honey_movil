import 'package:flutter/material.dart';
import 'package:h_honey/pages/clientesPage.dart';
import 'package:h_honey/pages/controlSegumientoPage.dart';
import 'package:h_honey/pages/ejemplaresPage.dart';
import 'package:h_honey/pages/pagosPage.dart';
import 'package:h_honey/pages/serviciosPage.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false
        // title: const Text('Menú Principal'),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       DrawerHeader(
      //         decoration: const BoxDecoration(color: Colors.amber),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Image.asset(
      //               'assets/images/logo.png',
      //               height: 80,
      //             ),
      //             const SizedBox(height: 10),
      //             const Text(
      //               'H-Honey',
      //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //             ),
      //           ],
      //         ),
      //       ),
      //       // Menú Hamburguesa
      //       ListTile(
      //         leading: const Icon(Icons.home),
      //         title: const Text('Menú Principal'),
      //         onTap: () {
      //           Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(builder: (context) => const MenuPage()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.person),
      //         title: const Text('Clientes'),
      //         onTap: () {
      //           Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(builder: (context) => const ClientesPage()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.miscellaneous_services),
      //         title: const Text('Servicios'),
      //         onTap: () {
      //           Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(builder: (context) => const ServiciosPage()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.category),
      //         title: const Text('Categoría de Ejemplares'),
      //         onTap: () {
      //           Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(builder: (context) => const EjemplaresPage()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.payment),
      //         title: const Text('Pagos'),
      //         onTap: () {
      //           Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(builder: (context) => const PagosPage()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.monitor_heart),
      //         title: const Text('Control y Seguimiento'),
      //         onTap: () {
      //           Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const ControlSeguimientoPage()),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: [
          // Íconos grandes de módulos
          _buildIconItem(context, Icons.person, 'Clientes', const ClientesPage()),
          _buildIconItem(context, Icons.business_center, 'Servicios', const ServiciosPage()),
          _buildIconItem(context, Icons.category, 'Categorias', const EjemplaresPage()),
          _buildIconItem(context, Icons.payment, 'Pagos', const PagosPage()),
          _buildIconItem(context, Icons.monitor_heart, 'Control', const ControlSeguimientoPage()),
        ],
      ),
    );
  }

  Widget _buildIconItem(BuildContext context, IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        color: const Color.fromARGB(255, 244, 224, 165),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 80,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
