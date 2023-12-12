
class Pedido {
  final String idCliente;
  final String tipo;
  final List<ProductoPedido> productos;
  final String cupon;  // Nuevo campo

  Pedido({
    required this.idCliente,
    required this.tipo,
    required this.productos,
    required this.cupon,  // Nuevo campo
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    List<ProductoPedido> productos = [];
    if (json['productos'] != null) {
      productos = List<ProductoPedido>.from(
        json['productos'].map((producto) => ProductoPedido.fromJson(producto)),
      );
    }

    return Pedido(
      idCliente: json['id_cliente'],
      tipo: json['tipo'],
      productos: productos,
      cupon: json['cupon'],  // Nuevo campo
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_cliente': idCliente,
      'tipo': tipo,
      'productos': productos.map((producto) => producto.toJson()).toList(),
      'cupon': cupon,  // Nuevo campo
    };
  }
}

class ProductoPedido {
  final String idProducto;
  final int cantidad;

  ProductoPedido({
    required this.idProducto,
    required this.cantidad,
  });

  factory ProductoPedido.fromJson(Map<String, dynamic> json) {
    return ProductoPedido(
      idProducto: json['id_producto'],
      cantidad: json['cantidad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_producto': idProducto,
      'cantidad': cantidad,
    };
  }
}
