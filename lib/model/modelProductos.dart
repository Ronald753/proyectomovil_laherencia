import 'package:json_annotation/json_annotation.dart';

part 'modelProductos.g.dart';

@JsonSerializable()
class Productos {
  @JsonKey(name: 'id_producto') // Asegura que coincide con el nombre del campo en la API
  String? id; // Cambiado de id_producto a id para mantener consistencia en el código
  String? nombre;
  String? descripcion;
  double? precio;
  String? imagen;
  bool? estado;
  @JsonKey(name: 'id_categoria')
  int? categoria;

  Productos({
    this.id,
    this.nombre,
    this.descripcion,
    this.precio,
    this.imagen,
    this.categoria,
  });

  factory Productos.fromJson(Map<String, dynamic> json) => _$ProductosFromJson(json);
  Map<String, dynamic> toJson() => _$ProductosToJson(this);
}

