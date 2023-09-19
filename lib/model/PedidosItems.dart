import 'package:proyectomovil/model/MenuItems.dart';



class Pedido {
  final int? id;
  final List<MenuItems>? productos; // Lista de productos en el pedido
  final DateTime? fechaPedido;
  final double? total;
  final String? estado; 
  String? puntuacion;

  Pedido({this.id, this.productos, this.fechaPedido, this.total, this.estado, this.puntuacion});
}

List<Pedido> pedidos = [
  Pedido(
    id: 1,
    productos: [
      MenuItems(id: 1, nombre: "Carne1", precio: 70, imagen: "carne.jpg", descripcion: "Lorem Ipsum is simply dummy Ipsum."),
      MenuItems(id: 2, nombre: "Carne2", precio: 9.99, imagen: "carne1.jpg", descripcion: "It is a long established humour and the like)."),
      // Agrega más productos según sea necesario
    ],
    fechaPedido: DateTime.now(),
    total: 90.0,
    estado: "Terminado",
    puntuacion: ''
  ),
  Pedido(
    id: 2,
    productos: [
      MenuItems(id: 2, nombre: "Carne2", precio: 9.99, imagen: "carne1.jpg", descripcion: "It is a long established humour and the like)."),
      // Agrega más productos según sea necesario
    ],
    fechaPedido: DateTime.now(),
    total: 100.0,
    estado: "Haciendo"
  ),
  // Agrega más pedidos según sea necesario
];


// Puedes crear más pedidos de la misma manera.
