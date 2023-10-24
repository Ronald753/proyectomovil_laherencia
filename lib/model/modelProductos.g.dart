// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelProductos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Productos _$ProductosFromJson(Map<String, dynamic> json) => Productos(
      id: json['id_producto'] as String?,
      nombre: json['nombre'] as String?,
      descripcion: json['descripcion'] as String?,
      precio: (json['precio'] as num?)?.toDouble(),
      imagen: json['imagen'] as String?,
      categoria: json['id_categoria'] as int?,
    )..estado = json['estado'] as bool?;

Map<String, dynamic> _$ProductosToJson(Productos instance) => <String, dynamic>{
      'id_producto': instance.id,
      'nombre': instance.nombre,
      'descripcion': instance.descripcion,
      'precio': instance.precio,
      'imagen': instance.imagen,
      'estado': instance.estado,
      'id_categoria': instance.categoria,
    };
