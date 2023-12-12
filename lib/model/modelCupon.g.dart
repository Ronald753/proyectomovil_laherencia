// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelCupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CuponModel _$CuponModelFromJson(Map<String, dynamic> json) => CuponModel(
      idCupon: json['idCupon'] as String,
      codigo: json['codigo'] as String,
      porcentajeDescuento: json['porcentajeDescuento'] as int,
      usosMaximos: json['usosMaximos'] as int,
      usosDisponibles: json['usosDisponibles'] as int,
    );

Map<String, dynamic> _$CuponModelToJson(CuponModel instance) =>
    <String, dynamic>{
      'idCupon': instance.idCupon,
      'codigo': instance.codigo,
      'porcentajeDescuento': instance.porcentajeDescuento,
      'usosMaximos': instance.usosMaximos,
      'usosDisponibles': instance.usosDisponibles,
    };
