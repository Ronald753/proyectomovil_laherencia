import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:proyectomovil/model/Carrito.dart';
import 'package:proyectomovil/model/modelProductos.dart';
import 'package:proyectomovil/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:proyectomovil/view/carrito_pantalla.dart';
import 'package:proyectomovil/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PantallaDetalles extends StatefulWidget {
  final Productos productosD;

  const PantallaDetalles({Key? key, required this.productosD})
      : super(key: key);

  @override
  _PantallaDetallesState createState() => _PantallaDetallesState();
}

class _PantallaDetallesState extends State<PantallaDetalles> {
  double? puntuacion;
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  bool _isLoggedIn = false;

  Future<String?> obtenerIdUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idUsuario');
  }

  @override
  void initState() {
    super.initState();
    _verificarInicioSesion();
  }

  Future<void> _verificarInicioSesion() async {
    String? userId = await obtenerIdUsuario();
    setState(() {
      _isLoggedIn = userId != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Carrito>(builder: (context, carrito, child) {
      return Scaffold(
        key: _globalKey,
        appBar: AppBar(
          title: Text("Detalles del Producto"),
          backgroundColor: Colors.amber,
          actions: <Widget>[
            new Stack(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      verificarSesionYAccederCarrito(context, carrito);
                    }),
                new Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4)),
                    constraints: BoxConstraints(minWidth: 14, minHeight: 14),
                    child: Text(
                      carrito.numeroProductos.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 9),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(widget.productosD.imagen ?? 'Imagen no disponible'),
              Text(widget.productosD.nombre ?? 'Nombre no disponible'),
              Text('Bs ${widget.productosD.precio ?? 'Precio no disponible'}'),
              Text(
                  widget.productosD.descripcion ?? 'Descripción no disponible'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  agregarAlCarrito(context, carrito);
                },
                child: Text("Agregar al Carrito"),
              )
            ],
          ),
        ),
      );
    });
  }

  void verificarSesionYAccederCarrito(
      BuildContext context, Carrito carrito) async {
    if (_isLoggedIn) {
      if (carrito.numeroProductos == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Agrega un producto"),
          ),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext) => PantallaCarrito(),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Inicia sesión para acceder al carrito."),
        ),
      );
    }
  }

  void agregarAlCarrito(BuildContext context, Carrito carrito) {
    if (_isLoggedIn) {
      setState(() {
        carrito.agregarItem(
          widget.productosD.id.toString(),
          widget.productosD.nombre.toString(),
          widget.productosD.precio?.toDouble() ?? 0.0,
          "1",
          widget.productosD.imagen.toString(),
          1,
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Debes iniciar sesión para agregar productos al carrito.'),
        ),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PantallaLogin()));
    }
  }
}
