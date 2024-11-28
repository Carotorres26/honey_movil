import 'package:flutter/material.dart';
import 'package:h_honey/pages/controlSegumientoPage.dart';
import 'package:h_honey/pages/serviciosPage.dart';
import 'package:h_honey/pages/menu_page.dart';
import 'package:h_honey/pages/pagosPage.dart';
import 'package:h_honey/pages/sedesPage.dart';
import 'package:h_honey/pages/clientesPage.dart';
import 'package:h_honey/pages/EjemplaresListPage.dart'; // Importa la página de lista de ejemplares

class EjemplaresPage extends StatefulWidget {
  const EjemplaresPage({super.key});

  @override
  _EjemplaresPageState createState() => _EjemplaresPageState();
}

class _EjemplaresPageState extends State<EjemplaresPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Categoria> filteredCategorias = categorias;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterCategorias);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCategorias() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredCategorias = categorias.where((categoria) {
        return categoria.nombre.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categoría de Ejemplares'),
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Buscar Categoría',
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
            Expanded(
              child: ListView.builder(
                itemCount: filteredCategorias.length,
                itemBuilder: (context, index) {
                  final categoria = filteredCategorias[index];
                  return _buildCategoriaCard(context, categoria);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  Widget _buildCategoriaCard(BuildContext context, Categoria categoria) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          // Redirigir a la página de lista de ejemplares al tocar la tarjeta
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EjemplaresListPage(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              const Icon(
                Icons.folder,
                color: Colors.amber,
                size: 28,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  categoria.nombre.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Datos quemados al final del archivo
class Categoria {
  final String nombre;

  Categoria(this.nombre);
}

final List<Categoria> categorias = [
  Categoria('Competencia'),
  Categoria('Receptoras'),
  Categoria('Potros'),
];
