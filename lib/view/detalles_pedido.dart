import 'package:flutter/material.dart';
import 'package:proyectomovil/model/PedidosItems.dart'; // Asegúrate de importar el modelo correcto
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PantallaDetallesPedido extends StatefulWidget {
  final Pedido pedido;

  PantallaDetallesPedido({required this.pedido});

  @override
  _PantallaDetallesPedidoState createState() => _PantallaDetallesPedidoState();
}

class _PantallaDetallesPedidoState extends State<PantallaDetallesPedido> {
  double? puntuacion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del Pedido #${widget.pedido.id}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Productos:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.pedido.productos?.map((producto) {
                return Text(
                  "- ${producto.nombre ?? 'Nombre no disponible'}",
                  style: TextStyle(fontSize: 16),
                );
              })?.toList() ?? [],
            ),
            SizedBox(height: 16),
            Text("Fecha del Pedido:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "${widget.pedido.fechaPedido?.toString() ?? 'Fecha no disponible'}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text("Total:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Bs ${widget.pedido.total?.toStringAsFixed(2) ?? 'N/A'}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text("Estado del Pedido:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "${widget.pedido.estado ?? 'Estado no disponible'}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "${widget.pedido.puntuacion ?? 'Puntuacion no disponible'}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            if (widget.pedido.puntuacion == '' && widget.pedido.estado == "Terminado") ...[
              Text("Calificar Pedido:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Calificar Pedido"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Por favor, califica este pedido:"),
                            RatingBar.builder(
                              initialRating: puntuacion ?? 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemSize: 40,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                // Actualiza la puntuación
                                setState(() {
                                  puntuacion = rating;
                                });
                              },
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(); // Cierra la ventana emergente
                            },
                            child: Text("Cancelar"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Aquí puedes enviar la calificación al servidor
                              // y guardarla en la variable puntuacion del pedido
                              widget.pedido.puntuacion = puntuacion.toString();
                              
                              Navigator.of(context)
                                  .pop(); // Cierra la ventana emergente
                            },
                            child: Text("Aceptar"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text("Puntuar"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
