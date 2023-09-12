import 'package:flutter/material.dart';
import 'package:proyectomovil/model/MenuItems.dart';
import 'package:proyectomovil/model/modelProductos.dart';

class PantallaDetalles extends StatelessWidget {
  final Productos productosD; // Usa la clase MenuItems en lugar de Plato

  const PantallaDetalles({Key? key, required this.productosD}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del Producto"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Image.network(productosD.imagen ?? 'Imagen no disponible'),
          Text(productosD.nombre ?? 'Nombre no disponible'),
          Text('Bs ${productosD.precio ?? 'Precio no disponible'}'),
          Text(productosD.descripcion ?? 'descripcion no disponible'),
        ],
      ),
    );
  }
}

