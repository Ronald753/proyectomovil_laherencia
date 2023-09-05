import 'package:flutter/material.dart';
import 'package:proyectomovil/model/MenuItems.dart';

class PantallaDetalles extends StatelessWidget {
  final MenuItems menuItems; // Usa la clase MenuItems en lugar de Plato

  const PantallaDetalles({Key? key, required this.menuItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del Producto"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Image.asset("assets/img/" + (menuItems?.imagen ?? "")),
          Text(menuItems?.nombre ?? ""),
          Text('Bs, ${menuItems.precio}'),
          Text(menuItems?.descripcion ?? ""),
        ],
      ),
    );
  }
}

