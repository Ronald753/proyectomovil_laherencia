import 'package:flutter/material.dart';
import 'package:proyectomovil/model/item.dart';

class Carrito extends ChangeNotifier {
  Map<String, Item> _items = {};
  Map<String, Item> get items {
    return {..._items};
  }

  int get numeroProductos {
    return _items.length;
  }

  double get montoTotal {
    var total = 0.0;
    items.forEach(
        (key, elementos) => total += elementos.precio * elementos.cantidad);
    return total;
  }
  

  void agregarItem(
    String producto_id,
    String nombre,
    double precio,
    String unidad,
    String imagen,
    int cantidad,
  ) {
    if (_items.containsKey(producto_id)) {
      _items.update(
        producto_id,
        (old) => Item(
          id: old.id,
          nombre: old.nombre,
          precio: old.precio,
          unidad: old.unidad,
          imagen: old.imagen,
          cantidad: old.cantidad + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
          producto_id,
          () => Item(
                id: producto_id,
                nombre: nombre,
                precio: precio,
                unidad: unidad,
                imagen: imagen,
                cantidad: 1,
              ));
    }
  }

  void removerItem(String producto_id) {
    _items.remove(producto_id);
  }

  void incrementarCantidadItem(String producto_id) {
    if (_items.containsKey(producto_id)) {
      _items.update(
        producto_id,
        (old) => Item(
          id: old.id,
          nombre: old.nombre,
          precio: old.precio,
          unidad: old.unidad,
          imagen: old.imagen,
          cantidad: old.cantidad + 1,
        ),
      );
    }
  }

  void decrementarCantidadItem(String producto_id) {
  if (!_items.containsKey(producto_id)) return;

  final item = _items[producto_id];
  if (item != null && item.cantidad! > 1) {
    _items.update(
      producto_id,
      (old) => Item(
        id: old.id,
        nombre: old.nombre,
        precio: old.precio,
        unidad: old.unidad,
        imagen: old.imagen,
        cantidad: old.cantidad - 1,
      ),
    );
  } else {
    _items.remove(producto_id);
  }
}



  void removeCarrito() {
    _items = {};
  }
}
