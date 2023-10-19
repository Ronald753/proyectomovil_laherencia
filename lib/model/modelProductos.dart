import 'package:json_annotation/json_annotation.dart';

part 'modelProductos.g.dart';

@JsonSerializable()
class Productos {
  @JsonKey(name: '_id')
  String? id;
  String? nombre;
  String? descripcion;
  double? precio;
  bool? estado;
  String? imagen;
  String? categoria;

  Productos({
    this.id,
    this.nombre,
    this.descripcion,
    this.precio,
    this.estado,
    this.imagen,
    this.categoria,
  });

  factory Productos.fromJson(Map<String, dynamic> json) => _$ProductosFromJson(json);
  Map<String, dynamic> toJson() => _$ProductosToJson(this);
}
