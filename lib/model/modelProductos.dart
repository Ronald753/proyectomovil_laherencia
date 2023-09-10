import 'package:json_annotation/json_annotation.dart';

part 'modelProductos.g.dart';

@JsonSerializable()
class Productos {
  int? id;
  String? nombre;
  String? descripcion;
  double? precio;
  bool? estado;
  String? imagen;

  Productos({
    this.id,
    this.nombre,
    this.descripcion,
    this.precio,
    this.estado,
    this.imagen,
  });

  factory Productos.fromJson(Map<String, dynamic> json) => _$ProductosFromJson(json);
  Map<String, dynamic> toJson() => _$ProductosToJson(this);
}
