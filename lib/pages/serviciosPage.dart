import 'package:flutter/material.dart';
import 'package:h_honey/pages/clientesPage.dart';
import 'package:h_honey/pages/controlSegumientoPage.dart';
import 'package:h_honey/pages/ejemplaresPage.dart';
import 'package:h_honey/pages/menu_page.dart';
import 'package:h_honey/pages/pagosPage.dart';
import 'package:h_honey/pages/sedesPage.dart';

class ServiciosPage extends StatefulWidget {
  const ServiciosPage({super.key});

  @override
  _ServiciosPageState createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Servicio> filteredServicios = servicios;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterServicios);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterServicios() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredServicios = servicios.where((servicio) {
        return servicio.nombre.toLowerCase().contains(query) ||
            servicio.descripcion.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios'),
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Buscador
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Buscar Servicio',
                  labelStyle: const TextStyle(color: Color(0xff3E2723)),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Colors.amber,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Colors.amber,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            // Lista de servicios
            Expanded(
              child: ListView.builder(
                itemCount: filteredServicios.length,
                itemBuilder: (context, index) {
                  return _buildServicioCard(context, filteredServicios[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Construir el menú lateral (drawer)
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
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
          _buildDrawerItem(
            context,
            title: 'Menú Principal',
            icon: Icons.home,
            page: const MenuPage(),
          ),
          _buildDrawerItem(
            context,
            title: 'Clientes',
            icon: Icons.person,
            page: const ClientesPage(),
          ),
          _buildDrawerItem(
            context,
            title: 'Servicios',
            icon: Icons.miscellaneous_services,
            page: const ServiciosPage(),
          ),
          _buildDrawerItem(
            context,
            title: 'Categoría de Ejemplares',
            icon: Icons.category,
            page: const EjemplaresPage(),
          ),
          _buildDrawerItem(
            context,
            title: 'Pagos',
            icon: Icons.payment,
            page: const PagosPage(),
          ),
          _buildDrawerItem(
            context,
            title: 'Sedes',
            icon: Icons.house,
            page: const SedesPage(),
          ),
          _buildDrawerItem(
            context,
            title: 'Control y Seguimiento',
            icon: Icons.monitor_heart,
            page: const ControlSeguimientoPage(),
          ),
        ],
      ),
    );
  }

  // Construir un ítem del menú lateral
  Widget _buildDrawerItem(BuildContext context,
      {required String title, required IconData icon, required Widget page}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
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
              height: 130,
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
                    servicio.nombre.toUpperCase(),
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

// Lista de servicios de ejemplo (datos quemados)
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
