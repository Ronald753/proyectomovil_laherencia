import 'package:flutter/material.dart';
import 'package:proyectomovil/view/inicio.dart';
import 'package:proyectomovil/view/login.dart';
import 'package:proyectomovil/view/menu.dart';
import 'package:proyectomovil/view/pedidos.dart';

class PantallaInicioBotones extends StatefulWidget {
  const PantallaInicioBotones({super.key});

  @override
  State<PantallaInicioBotones> createState() => _PantallaInicioBotonesState();
}

class _PantallaInicioBotonesState extends State<PantallaInicioBotones> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    PantallaInicio(),
    PantallaMenu(),
    PantallaPedidos(),
    PantallaLogin(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        unselectedItemColor: Colors.grey, // Color para íconos no seleccionados
        selectedItemColor: Colors.purple, // Color para ícono seleccionado
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: "Menú",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Pedidos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}