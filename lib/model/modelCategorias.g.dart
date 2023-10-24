// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelCategorias.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Categorias _$CategoriasFromJson(Map<String, dynamic> json) => Categorias(
      idCategoria: json['id_categoria'] as int?,
      nombre: json['nombre'] as String?,
      estado: json['estado'] as bool?,
    );

Map<String, dynamic> _$CategoriasToJson(Categorias instance) =>
    <String, dynamic>{
      'id_categoria': instance.idCategoria,
      'nombre': instance.nombre,
      'estado': instance.estado,
    };
