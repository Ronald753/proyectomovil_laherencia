import 'package:flutter/material.dart';
import 'package:proyectomovil/model/PedidosCliente.dart';
import 'package:proyectomovil/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class PantallaPedidos extends StatelessWidget {
  const PantallaPedidos({Key? key});

  @override
  Widget build(BuildContext context) {
    Future<String?> obtenerIdUsuario() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('idUsuario');
    }

    Future<List<PedidosCliente>> obtenerPedidos(String idUsuario) async {
      try {
        final apiService = ApiService(Dio());
        final response = await apiService.getPedidosByUserId(idUsuario);

        if (response.isNotEmpty) {
          List<PedidosCliente> pedidos = List<PedidosCliente>.from(
            response,
          );

          pedidos.sort((a, b) {
            int comparacionFecha = b.fecha.compareTo(a.fecha);

            if (comparacionFecha == 0) {
              return b.hora.compareTo(a.hora);
            }

            return comparacionFecha;
          });

          return pedidos;
        } else {
          throw Exception('Error al cargar los pedidos');
        }
      } catch (e) {
        throw Exception('Error al cargar los pedidos');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Pedidos',
          style: TextStyle(
            color: Colors.white, // Cambia el color de la letra aquí
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<String?>(
        future: obtenerIdUsuario(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al obtener el ID del usuario'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Es necesario iniciar sesión para visualizar los pedidos.'));
          } else {
            String idUsuario = snapshot.data!;
            return FutureBuilder<List<PedidosCliente>>(
              future: obtenerPedidos(idUsuario),
              builder: (context, snapshotPedidos) {
                if (snapshotPedidos.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshotPedidos.hasError) {
                  return Center(child: Text('No realizo ningún pedido'));
                } else if (!snapshotPedidos.hasData ||
                    snapshotPedidos.data!.isEmpty) {
                  return Center(child: Text('No realizo ningún pedido'));
                } else {
                  return ListView.builder(
                    itemCount: snapshotPedidos.data!.length,
                    itemBuilder: (context, index) {
                      PedidosCliente pedido = snapshotPedidos.data![index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text('Fecha: ${pedido.fecha}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hora: ${pedido.hora}'),
                              Text('Monto Total: \$${pedido.montoTotal}'),
                              Text('Estado: ${pedido.estado}',
                                style: TextStyle(
                                  color: getColorForEstado(pedido.estado),
                                  // Puedes ajustar otros estilos según tus necesidades, como fontSize, fontWeight, etc.
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

    Color getColorForEstado(String estado) {
    switch (estado.toLowerCase()) {
      case 'pendiente':
        return Colors.blue;
      case 'confirmado':
        return Colors.amber;
      case 'cancelado':
        return Colors.red;
      case 'listo':
        return Colors.green;
      case 'entregado':
        return Colors.grey;
      default:
        // Puedes manejar un estado desconocido aquí, por ejemplo, devolver Colors.black
        return Colors.black;
    }
  }
}
