import 'package:flutter/material.dart';
import 'package:h_honey/pages/controlSegumientoPage.dart';
import 'package:h_honey/pages/ejemplaresPage.dart';
import 'package:h_honey/pages/menu_page.dart';
import 'package:h_honey/pages/serviciosPage.dart';
import 'package:h_honey/pages/clientesPage.dart';

class PagosPage extends StatefulWidget {
  const PagosPage({super.key});

  @override
  _PagosPageState createState() => _PagosPageState();
}

class _PagosPageState extends State<PagosPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Pago> filteredPagos = [];
  int _currentPage = 0;
  final int _itemsPerPage = 3;

  @override
  void initState() {
    super.initState();
    filteredPagos = _getPagos();
    _searchController.addListener(_filterPagos);
  }

  void _filterPagos() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredPagos = _getPagos().where((pago) {
        return pago.nombre.toLowerCase().contains(query) ||
            pago.documento.toLowerCase().contains(query) ||
            pago.ejemplar.toLowerCase().contains(query);
      }).toList();
      _currentPage = 0; // Reinicia la página al filtrar
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paginatedPagos = _getPaginatedPagos();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagos'),
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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Buscar por nombre, documento o ejemplar',
                      labelStyle: const TextStyle(
                        color: Color(0xff3E2723),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            const BorderSide(color: Colors.amber, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            const BorderSide(color: Colors.amber, width: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Agregar espacio para que la paginación quede más cerca del contenido
            Expanded(
              child: ListView.builder(
                itemCount: paginatedPagos.length,
                itemBuilder: (context, index) {
                  final pago = paginatedPagos[index];
                  return _buildPagoCard(pago);
                },
              ),
            ),

            // Paginación en la parte inferior pero no tan abajo
            _buildPaginationControls(),
          ],
        ),
      ),
    );
  }

  List<Pago> _getPaginatedPagos() {
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    return filteredPagos.sublist(
      startIndex,
      endIndex > filteredPagos.length ? filteredPagos.length : endIndex,
    );
  }

  Widget _buildPagoCard(Pago pago) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Nombre', pago.nombre),
            _buildDetailRow('Documento', pago.documento),
            _buildDetailRow('Ejemplar', pago.ejemplar),
            _buildStatusRow('Estado del Pago', pago.estado),
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

  Widget _buildStatusRow(String label, String estado) {
    Color dotColor = estado == 'Pagado' ? Colors.green : Colors.amber;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Icon(Icons.circle, size: 16, color: dotColor),
        ],
      ),
    );
  }

  Widget _buildPaginationControls() {
    int totalPages = (filteredPagos.length / _itemsPerPage).ceil();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _currentPage > 0
                ? () {
                    setState(() {
                      _currentPage--;
                    });
                  }
                : null,
            icon: const Icon(Icons.arrow_back),
          ),
          Text('${_currentPage + 1} de $totalPages'),
          IconButton(
            onPressed: _currentPage < totalPages - 1
                ? () {
                    setState(() {
                      _currentPage++;
                    });
                  }
                : null,
            icon: const Icon(Icons.arrow_forward),
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
}

// Datos quemados
List<Pago> _getPagos() {
  return [
    Pago(
      nombre: 'Juan Pérez',
      documento: '102030405',
      ejemplar: 'Atractivo',
      estado: 'Pagado',
    ),
    Pago(
      nombre: 'María Rodríguez',
      documento: '506070809',
      ejemplar: 'Don Juan',
      estado: 'Pendiente',
    ),
    Pago(
      nombre: 'Luis González',
      documento: '708090102',
      ejemplar: 'Corcel Negro',
      estado: 'Pagado',
    ),
    Pago(
      nombre: 'Ana López',
      documento: '203040506',
      ejemplar: 'Dulcinea',
      estado: 'Pendiente',
    ),
  ];
}

// Clase para los datos de los pagos
class Pago {
  final String nombre;
  final String documento;
  final String ejemplar;
  final String estado;

  Pago({
    required this.nombre,
    required this.documento,
    required this.ejemplar,
    required this.estado,
  });
}
