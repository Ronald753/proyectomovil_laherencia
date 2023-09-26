import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:proyectomovil/model/modelProductos.dart';
import 'package:proyectomovil/service/api_service.dart';
import 'package:dio/dio.dart';


class PantallaDetalles extends StatefulWidget {
  final Productos productosD;

  const PantallaDetalles({Key? key, required this.productosD}) : super(key: key);

  @override
  _PantallaDetallesState createState() => _PantallaDetallesState();
}

class _PantallaDetallesState extends State<PantallaDetalles> {
  double? puntuacion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del Producto"),
        backgroundColor: Colors.amber,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(widget.productosD.imagen ?? 'Imagen no disponible'),
            Text(widget.productosD.id ?? 'Id no disponible'),
            Text(widget.productosD.nombre ?? 'Nombre no disponible'),
            Text('Bs ${widget.productosD.precio ?? 'Precio no disponible'}'),
            Text(widget.productosD.descripcion ?? 'Descripción no disponible'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Agregar lógica para agregar el producto al carrito aquí
              },
              child: Text("Agregar al Carrito"),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Calificar Producto"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Por favor, califica este producto:"),
                          RatingBar.builder(
                            initialRating: puntuacion ?? 1,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemSize: 40,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
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
                            Navigator.of(context).pop(); // Cierra la ventana emergente
                          },
                          child: Text("Cancelar"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final rating = puntuacion;
                            
                            try {
                              final apiService = ApiService(Dio()); // Crea una instancia de ApiService
                              
                              // Llama al método para actualizar la puntuación en la API
                              await apiService.updateProducto(
                                widget.productosD.id.toString(), // ID del producto
                                {'puntuacion': rating}, // Datos de la puntuación
                              );

                              // Puedes manejar la respuesta del servidor si es necesario

                              Navigator.of(context).pop(); // Cierra la ventana emergente
                            } catch (error) {
                              // Maneja cualquier error que pueda ocurrir durante la solicitud de actualización
                              print('Error al actualizar la puntuación: $error');
                              // Puedes mostrar un mensaje de error al usuario si es necesario
                            }
                          },
                          child: Text("Aceptar"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text("Calificar Producto"),
            ),
          ],
        ),
      ),
    );
  }
}
