import 'package:flutter/material.dart';
import 'package:h_honey/pages/menu_page.dart';
import 'package:h_honey/pages/clientesPage.dart';
import 'package:h_honey/pages/serviciosPage.dart';
import 'package:h_honey/pages/controlSegumientoPage.dart';
import 'package:h_honey/pages/pagosPage.dart';

class EjemplaresListPage extends StatefulWidget {
  const EjemplaresListPage({super.key});

  @override
  _EjemplaresListPageState createState() => _EjemplaresListPageState();
}

class _EjemplaresListPageState extends State<EjemplaresListPage> {
  final TextEditingController _searchController = TextEditingController();
  
  List<Ejemplar> filteredEjemplares = [];
  int currentPage = 0;
  final int itemsPerPage = 2; // Número de ejemplares por página

  @override
  void initState() {
    super.initState();
    filteredEjemplares = _getEjemplares();
    _searchController.addListener(_filterEjemplares);
  }

  void _filterEjemplares() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredEjemplares = _getEjemplares().where((ejemplar) {
        return ejemplar.nombre.toLowerCase().contains(query) ||
               ejemplar.dueno.toLowerCase().contains(query);
      }).toList();
      currentPage = 0; // Restablecer a la primera página al hacer búsqueda
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calcular la cantidad de páginas
    final pageCount = (filteredEjemplares.length / itemsPerPage).ceil();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplares'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Abre el Drawer
              },
            );
          },
        ),
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
              title: 'Pagos',
              icon: Icons.payment,
              page: const PagosPage(),
            ),
            _buildDrawerItem(
              context,
              title: 'Control y Seguimiento',
              icon: Icons.monitor_heart,
              page: const ControlSeguimientoPage(),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Categorías'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xff3E2723), 
                      backgroundColor: const Color(0xffFFC107),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Buscar Ejemplar o Dueño',
                        labelStyle: const TextStyle(color: Color(0xff3E2723)),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            color: Colors.amber, width: 2
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            color: Colors.amber, width: 2
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: itemsPerPage,
                itemBuilder: (context, index) {
                  final itemIndex = index + (currentPage * itemsPerPage);
                  if (itemIndex < filteredEjemplares.length) {
                    final ejemplar = filteredEjemplares[itemIndex];
                    return _buildEjemplarCard(ejemplar);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: currentPage > 0
                        ? () {
                            setState(() {
                              currentPage--;
                            });
                          }
                        : null,
                  ),
                  Text('Página ${currentPage + 1} de $pageCount'),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: currentPage < pageCount - 1
                        ? () {
                            setState(() {
                              currentPage++;
                            });
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEjemplarCard(Ejemplar ejemplar) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ejemplar.nombre,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            _buildDetailRow('Fecha de Nacimiento', ejemplar.fechaNacimiento),
            _buildDetailRow('Edad', '${ejemplar.edadEnMeses} meses'),
            _buildDetailRow('Paso', ejemplar.paso),
            _buildDetailRow('Color', ejemplar.color),
            const SizedBox(height: 15),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              'Información del Dueño:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            _buildDetailRow('Nombre', ejemplar.dueno),
            _buildDetailRow('Cédula', ejemplar.cedula),
            _buildDetailRow('Correo', ejemplar.correo),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  List<Ejemplar> _getEjemplares() {
    return [
      Ejemplar(
        nombre: 'Atractivo',
        fechaNacimiento: '05/01/2018',
        edadEnMeses: 72,
        paso: 'Trocha',
        color: 'Castaño Claro',
        dueno: 'Juan Pérez',
        cedula: '102030405',
        correo: 'juan.perez@gmail.com',
      ),
      Ejemplar(
        nombre: 'Don Juan',
        fechaNacimiento: '12/03/2017',
        edadEnMeses: 84,
        paso: 'Galope',
        color: 'Negro',
        dueno: 'María Rodríguez',
        cedula: '506070809',
        correo: 'maria.rodriguez@gmail.com',
      ),
      Ejemplar(
        nombre: 'Héroe',
        fechaNacimiento: '15/06/2019',
        edadEnMeses: 60,
        paso: 'Paso Fino',
        color: 'Blanco',
        dueno: 'Carlos Sánchez',
        cedula: '120304050',
        correo: 'carlos.sanchez@gmail.com',
      ),
      // Agregar más ejemplares aquí...
    ];
  }

  Widget _buildDrawerItem(BuildContext context,
      {required String title, required IconData icon, required Widget page}) {
    return ListTile(
      leading: Icon(icon, color: Colors.amber),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}

class Ejemplar {
  final String nombre;
  final String fechaNacimiento;
  final int edadEnMeses;
  final String paso;
  final String color;
  final String dueno;
  final String cedula;
  final String correo;

  Ejemplar({
    required this.nombre,
    required this.fechaNacimiento,
    required this.edadEnMeses,
    required this.paso,
    required this.color,
    required this.dueno,
    required this.cedula,
    required this.correo,
  });
}
