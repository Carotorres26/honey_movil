import 'package:flutter/material.dart';
import 'package:h_honey/pages/clientesPage.dart';
import 'package:h_honey/pages/controlSegumientoPage.dart';
import 'package:h_honey/pages/ejemplaresPage.dart';
import 'package:h_honey/pages/menu_page.dart';
import 'package:h_honey/pages/pagosPage.dart';
import 'package:h_honey/pages/sedesPage.dart';

class ServiciosPage extends StatelessWidget {
  const ServiciosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
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
              title: const Text('Control y Seguimiento'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ControlSeguimientoPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: servicios.length,
          itemBuilder: (context, index) {
            return _buildServicioCard(context, servicios[index]);
          },
        ),
      ),
    );
  }

  // Construir la tarjeta de un servicio
  Widget _buildServicioCard(BuildContext context, Servicio servicio) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del servicio
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(15)),
            child: Container(
              width: 120, // Imagen más grande
              height: 120,
              color: Colors.grey[200],
              child: Image.asset(
                servicio.imagen,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Detalles del servicio
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre del servicio
                  Text(
                    servicio.nombre,
                    style: const TextStyle(
                      fontSize: 18, // Fuente más grande
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Descripción del servicio
                  Text(
                    servicio.descripcion,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Estado del servicio representado por un punto de color
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: servicio.estado ? Colors.green : Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        servicio.estado ? "Activo" : "Inactivo",
                        style: const TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Modelo de datos para un servicio
class Servicio {
  final String nombre;
  final String descripcion;
  final String imagen;
  final bool estado;

  Servicio({
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.estado,
  });
}

// Lista de servicios de ejemplo
final List<Servicio> servicios = [
  Servicio(
    nombre: 'Alimentación',
    descripcion: 'Servicio de alimentación para los caballos.',
    imagen: 'assets/images/alimentacion.jpeg',
    estado: true,
  ),
  Servicio(
    nombre: 'Pesebrera',
    descripcion: 'Cuidado y mantenimiento de las pesebras.',
    imagen: 'assets/images/pesebrera.jpg',
    estado: false,
  ),
  Servicio(
    nombre: 'Veterinaria',
    descripcion: 'Consultas y atención veterinaria para los caballos.',
    imagen: 'assets/images/veterinaria.avif',
    estado: true,
  ),
];
