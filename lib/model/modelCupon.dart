import 'package:json_annotation/json_annotation.dart';

part 'modelCupon.g.dart';

@JsonSerializable()
class CuponModel {
  final String idCupon;
  final String codigo;
  final int porcentajeDescuento;
  final int usosMaximos;
  final int usosDisponibles;

  CuponModel({
    required this.idCupon,
    required this.codigo,
    required this.porcentajeDescuento,
    required this.usosMaximos,
    required this.usosDisponibles,
  });

  factory CuponModel.fromJson(Map<String, dynamic> json) {
    return CuponModel(
      idCupon: json['id_cupon'],
      codigo: json['codigo'],
      porcentajeDescuento: json['porcentajeDescuento'],
      usosMaximos: json['usosMaximos'],
      usosDisponibles: json['usosDisponibles'],
    );
  }
}
