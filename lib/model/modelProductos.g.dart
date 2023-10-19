// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelProductos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Productos _$ProductosFromJson(Map<String, dynamic> json) => Productos(
      id: json['_id'] as String?,
      nombre: json['nombre'] as String?,
      descripcion: json['descripcion'] as String?,
      precio: (json['precio'] as num?)?.toDouble(),
      estado: json['estado'] as bool?,
      imagen: json['imagen'] as String?,
      categoria: json['categoria'] as String?,
    );

Map<String, dynamic> _$ProductosToJson(Productos instance) => <String, dynamic>{
      '_id': instance.id,
      'nombre': instance.nombre,
      'descripcion': instance.descripcion,
      'precio': instance.precio,
      'estado': instance.estado,
      'imagen': instance.imagen,
      'categoria': instance.categoria,
    };
