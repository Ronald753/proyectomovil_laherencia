import 'package:flutter/material.dart';
import 'package:proyectomovil/model/MenuItems.dart';
import 'package:proyectomovil/model/modelCategorias.dart';
import 'package:proyectomovil/view/detalles.dart';
import 'package:proyectomovil/model/modelProductos.dart';
import 'package:proyectomovil/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:proyectomovil/model/Carrito.dart';
import 'package:proyectomovil/view/carrito_pantalla.dart';


class PantallaMenu extends StatelessWidget {
  const PantallaMenu({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  FutureBuilder _body() {
    final apiService = ApiService(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder(
      future: apiService.getCategorias(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          final List<Categorias> categorias = snapshot.data!;
          return _categoriasTabView(categorias, apiService);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _categoriasTabView(List<Categorias> categorias, ApiService apiService) {
    return Consumer<Carrito>(builder: (context, carrito, child){
      return DefaultTabController(
        length: categorias.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Menu"),
            backgroundColor: Colors.amber,
            elevation: 0,
            bottom: TabBar(
              isScrollable: true, // Esto permite desplazarse horizontalmente
              labelColor: Colors.red,
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: categorias.map((categoria) => Tab(child: Text(categoria.nombre ?? 'Nombre no disponible'))).toList(),
            ),
            actions: <Widget>[
              new Stack(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart), 
                    onPressed: (){
                      if(carrito.numeroProductos == 0){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Agrega un producto"),
                          ),
                        );
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext) => PantallaCarrito()
                          ));
                      }
                    }
                  ),
                  new Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4)),
                        constraints: BoxConstraints(
                          minWidth: 14,
                          minHeight: 14
                        ),
                      child: Text(
                        carrito.numeroProductos.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 9
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          body: TabBarView(
            children: categorias.map((categoria) {
              return FutureBuilder(
                future: apiService.getProductos(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    final List<Productos> productos = snapshot.data!;
                    final productosFiltrados = productos.where((producto) => producto.categoria == categoria.idCategoria).toList();
                    return Container(
                      padding: EdgeInsets.all(5),
                      child: GridView.builder(
                        itemCount: productosFiltrados.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 2,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PantallaDetalles(productosD: productosFiltrados[index]),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: <Widget>[
                                  Image.network(
                                    productosFiltrados[index].imagen ?? 'Imagen no disponible',
                                    height: 90,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(productosFiltrados[index].nombre ?? 'Nombre no disponible'),
                                  Text('Bs ${productosFiltrados[index].precio ?? 'Precio no disponible'}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}
