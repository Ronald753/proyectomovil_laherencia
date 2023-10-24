import 'package:json_annotation/json_annotation.dart';

part 'modelCategorias.g.dart';

@JsonSerializable()
class Categorias {
  @JsonKey(name: 'id_categoria') // Asegura que coincide con el nombre del campo en la API
  int? idCategoria; // Cambiado de id_producto a id para mantener consistencia en el código
  String? nombre;
  bool? estado;

  Categorias({
    this.idCategoria,
    this.nombre,
    this.estado
  });

  factory Categorias.fromJson(Map<String, dynamic> json) => _$CategoriasFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriasToJson(this);
}