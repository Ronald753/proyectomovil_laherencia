import 'package:flutter/material.dart';
import 'package:proyectomovil/model/PedidosItems.dart';
import 'package:proyectomovil/view/detalles_pedido.dart';
import 'package:intl/intl.dart';

class PantallaPedidos extends StatelessWidget {
  const PantallaPedidos({Key? key});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat('dd/MM/yyyy HH:mm');
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos"),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        itemCount: pedidos.length,
        itemBuilder: (context, index) {
          final pedido = pedidos[index];
          return ListTile(
            title: Text("Pedido #${pedido.id}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: pedido.productos?.map((producto) {
                return Text(producto.nombre ?? 'Nombre no disponible');
              })?.toList() ?? [],
            ),
            contentPadding: EdgeInsets.all(18), // Ajusta los valores según sea necesario
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos en el trailing
              children: [
                Text("Total: Bs ${pedido.total?.toStringAsFixed(2) ?? 'N/A'}"),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 40, // Limita la altura del contenido a 50 píxeles
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PantallaDetallesPedido(pedido: pedido),
                      ));
                    },
                    child: Text("Ver Detalles"),
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }
}


