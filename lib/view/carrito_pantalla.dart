import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectomovil/model/Carrito.dart';
import 'package:proyectomovil/model/modelPedido.dart';
import 'package:proyectomovil/service/api_service.dart';
import 'package:proyectomovil/model/modelCupon.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PantallaCarrito extends StatefulWidget {
  @override
  _PantallaCarritoState createState() => _PantallaCarritoState();
}

class _PantallaCarritoState extends State<PantallaCarrito> {
  TextEditingController _cuponController = TextEditingController();

  Future<String?> obtenerIdUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idUsuario');
  }

  Future<void> _enviarPedido(Pedido pedido) async {
    final apiService = ApiService(Dio());
 
    try {
      // Envía el pedido a la API usando el método enviarPedido de ApiService
      await apiService.enviarPedido(pedido);

      // Actualiza el estado del widget para reflejar los cambios
      setState(() {});
    } catch (error) {
      // Manejar errores aquí, como mostrar un mensaje al usuario
      print('Error al enviar el pedido: $error');
    }
  }



  String _tipoPedido = "";
  void _mostrarVentanaEmergenteEnviar(BuildContext context, Carrito carrito) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Pedido'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '¿El pedido es para llevar?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                //Text('¿Deseas enviar el pedido?'),
              ],
            ),
          ),

          actions: <Widget>[
            /*
            TextButton(
              child: Text('Cancelar'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            */
            TextButton(
              child: Text('No'),
              onPressed: () async {
                _tipoPedido = 'Local';
                Navigator.of(context).pop();
                _mostrarVentanaEmergente(context, carrito);
              },
            ),
            TextButton(
              child: Text('Si'),
              onPressed: () async {
                _tipoPedido = 'Para llevar';
                Navigator.of(context).pop();
                _mostrarVentanaEmergente(context, carrito);
              },
            ),
          ],
        );
      },
    );
  }
  bool _cuponValido = false;
  OverlayEntry? _overlayEntry;

  void _showOverlayMessage(String message, bool isError) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        child: Material(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: isError ? Colors.red : Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);

    // Oculta el mensaje después de un tiempo (puedes ajustar según tus necesidades)
    Future.delayed(Duration(seconds: 3), () {
      _overlayEntry?.remove();
    });
  }

  String cuponEnviado = '';
  
  Future<void> getCuponPorCodigo() async {
    final apiService = ApiService(Dio());

    try {
      // Obtén el cupón del controlador (o de donde sea que esté definido)
      String _cupon = _cuponController.text;

      // Envía la solicitud a la API para obtener el modelo de cupón
      CuponModel? _cuponModel = await apiService.getCuponPorCodigo(_cupon);

      if (_cuponModel != null) {
        // Verifica si el cupón es válido
        if (_cuponModel.usosDisponibles == 0) {
          // Cupón no disponible si usosDisponibles es igual a cero
          _cuponValido = false;
          cuponEnviado = '';
          _showOverlayMessage(
            'El cupón $_cupon no está disponible. Usos agotados.',
            true,
          );
        } else {
          // El cupón es válido
          _cuponValido = true;
          cuponEnviado = _cupon;
          int descuentoPorcentaje= _cuponModel.porcentajeDescuento;

          _showOverlayMessage(
            'El cupón $_cupon es válido. Tienes un descuento del $descuentoPorcentaje%',
            false,
          );
        }
      } else {
        // Manejar el caso donde el modelo de cupón es nulo
        print('No se pudo obtener el modelo de cupón o el cupón no es válido');
        _cuponValido = false;
        cuponEnviado = '';
        _showOverlayMessage(
          'El cupón $_cupon no es válido.',
          true,
        );
      }
    } catch (error) {
      // Manejar errores aquí, como mostrar un mensaje al usuario
      print('Error al obtener el modelo de cupón: $error');
      cuponEnviado = '';

      // Muestra un mensaje de error genérico
       _showOverlayMessage(
        'Ocurrió un error al obtener el cupón.',
        true,
      );
    }
  }
  

  void _mostrarVentanaEmergente(BuildContext context, Carrito carrito) {
    String _cupon = "";
    //double precioDescuento = 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ingresar cupon'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Si dispones de un cupón, introdúcelo a continuación. Si el cupón es válido, se aplicará un descuento.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _cuponController,
                  decoration: InputDecoration(
                    labelText: 'Cupón',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    getCuponPorCodigo(); // Llama a la función cuando se hace clic en el botón
                  },
                  child: Text('Verificar cupón'),
                ),

                /*
                ElevatedButton(
                onPressed: () {
                  _cupon = _cuponController.text;

                  // Aquí, deberías tener una lógica para validar el cupón y obtener su descuento
                  bool cuponValido = true; // Cambia esto con la lógica real
                  double descuentoCupon = cuponValido && cuponModel != null ? cuponModel.porcentajeDescuento / 100.0 : 0.0;

                  // Calcula el precio total aplicando el descuento
                  double precioTotalConDescuento = carrito.montoTotal * (1 - descuentoCupon);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'El cupón "$_cupon" es ${cuponValido ? 'válido' : 'inválido'}.',
                      ),
                    ),
                  );

                  // Actualiza el estado para reflejar el nuevo precio total con descuento
                  setState(() {
                    precioDescuento = precioTotalConDescuento;
                  });
                },
                child: Text('Verificar'),
              ),

              Text("Total: " + "Bs " + precioDescuento.toString()),
              */

                SizedBox(height: 16),
                Text('¿Deseas enviar el pedido?'),
              ],
            ),
          ),

          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Enviar'),
              onPressed: () async {
                _cupon = _cuponController.text;
                String idCliente = (await obtenerIdUsuario()) ?? '';
                final pedido = Pedido(
                  idCliente: idCliente,
                  tipo: _tipoPedido,
                  productos: carrito.items.values.map((item) {
                    return ProductoPedido(
                        idProducto: item.id, cantidad: item.cantidad);
                  }).toList(),
                  cupon: _cupon,
                );

                _enviarPedido(pedido);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Pedido enviado. Cupón: $cuponEnviado'),
                  ),
                );

                carrito.removeCarrito();

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Carrito>(builder: (context, carrito, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Pedidos",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: carrito.items.length == 0
              ? Center(
                  child: Text("Carrito vacio"),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (var item in carrito.items.values)
                      Card(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Image.network(
                              item.imagen,
                              width: 100,
                            ),
                            Expanded(
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(item.nombre),
                                      Text("Bs " +
                                          item.precio.toString() +
                                          " x " +
                                          item.unidad),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.remove,
                                                size: 13,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  carrito
                                                      .decrementarCantidadItem(
                                                          item.id);
                                                });
                                              },
                                            ),
                                            width: 50,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                          ),
                                          Container(
                                            width: 20,
                                            child: Center(
                                              child: Text(
                                                  item.cantidad.toString()),
                                            ),
                                          ),
                                          Container(
                                            child: IconButton(
                                                icon: Icon(
                                                  Icons.add,
                                                  size: 13,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    carrito
                                                        .incrementarCantidadItem(
                                                            item.id);
                                                  });
                                                }),
                                            width: 50,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                            Container(
                              height: 100,
                              width: 70,
                              decoration:
                                  BoxDecoration(color: Color(0x99f0f0f0)),
                              child: Center(
                                child: Text("Bs " +
                                    (item.precio * item.cantidad).toString()),
                              ),
                            )
                          ],
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          //Expanded(child: Text("Total")),

                          Text("Total: " +
                              "Bs " +
                              carrito.montoTotal.toString()),
                        ],
                      ),
                    )
                  ],
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (carrito.numeroProductos == 0) {
              // Muestra un mensaje de Snackbar informando que el carrito está vacío
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'El carrito está vacío. Agrega productos antes de enviar el pedido.'),
                ),
              );
            } else {
              // Muestra la ventana emergente de confirmación
              _mostrarVentanaEmergenteEnviar(context, carrito);
            }
          },
          backgroundColor: Colors.red,
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
