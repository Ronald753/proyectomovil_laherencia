
import 'package:json_annotation/json_annotation.dart';

part 'PedidosCliente.g.dart';

@JsonSerializable()
class PedidosCliente {
  final String idPedido;
  final String fecha;
  final String hora;
  final double montoTotal;
  final String estado;
  final String idCliente;

  PedidosCliente({
    required this.idPedido,
    required this.fecha,
    required this.hora,
    required this.montoTotal,
    required this.estado,
    required this.idCliente,
  });

  factory PedidosCliente.fromJson(Map<String, dynamic> json) {
    return PedidosCliente(
      idPedido: json['id_pedido'],
      fecha: json['fecha'],
      hora: json['hora'],
      montoTotal: json['montoTotal'].toDouble(),
      estado: json['estado'],
      idCliente: json['id_cliente'],
    );
  }
}
