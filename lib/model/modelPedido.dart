class Pedido {
  final String idCliente;
  final List<ProductoPedido> productos;

  Pedido({
    required this.idCliente,
    required this.productos,
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
      productos: productos,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_cliente': idCliente,
      'productos': productos.map((producto) => producto.toJson()).toList(),
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
