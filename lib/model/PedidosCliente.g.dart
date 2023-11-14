// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PedidosCliente.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PedidosCliente _$PedidosClienteFromJson(Map<String, dynamic> json) =>
    PedidosCliente(
      idPedido: json['idPedido'] as String,
      fecha: json['fecha'] as String,
      hora: json['hora'] as String,
      montoTotal: (json['montoTotal'] as num).toDouble(),
      estado: json['estado'] as String,
      idCliente: json['idCliente'] as String,
    );

Map<String, dynamic> _$PedidosClienteToJson(PedidosCliente instance) =>
    <String, dynamic>{
      'idPedido': instance.idPedido,
      'fecha': instance.fecha,
      'hora': instance.hora,
      'montoTotal': instance.montoTotal,
      'estado': instance.estado,
      'idCliente': instance.idCliente,
    };
