import 'package:flutter/material.dart';
import 'package:proyectomovil/model/modelProductos.dart';
import 'package:proyectomovil/service/api_service.dart';
import 'package:proyectomovil/view/detalles.dart';
import 'package:dio/dio.dart';

class pruebaapi extends StatelessWidget {
  const pruebaapi({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1D1E22),
        title: const Text('Flutter'),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  FutureBuilder _body(){
    final apiService =ApiService(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder(
        future: apiService.getProductos(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            final List<Productos> productos = snapshot.data!;
            return _productos(productos);
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
      }
    );
  }

  Widget _productos(List<Productos> productos) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Menu"),
          backgroundColor: Colors.amber,
          elevation: 0,
          bottom: TabBar(
            labelColor: Colors.red,
            indicatorColor: Colors.red,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(fontSize: 16.0),
            tabs: <Widget>[
              Tab(
                child: Text("Platos"),
              ),
              Tab(
                child: Text("Guarniciones"),
              ),
              Tab(
                child: Text("Gaseosas y jugos"),
              ),
              Tab(
                child: Text("Aperitivos"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
              Container(
              padding: EdgeInsets.all(5),
              child: GridView.builder(
                itemCount: productos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  //childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.5),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navega a la pantalla de detalles del producto y pasa el objeto 'menuItems'
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          //builder: (context) => PantallaDetalles((Productos): productos), // Pasa el objeto menuItems
                            builder: (context) => PantallaDetalles(productosD: productos[index]),
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
                          //Image.asset("assets/img/" + (plato?.imagen ?? "")),
                          Text(productos[index].nombre ?? 'Nombre no disponible'),
                          Text('Bs ${productos[index].precio ?? 'Precio no disponible'}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Text("Guarniciones"),
            ),
            Container(
              child: Text("Gaseosas y jugos"),
            ),
            Container(
              child: Text("Aperitivos"),
            ),
          ],
        ),
      ),
    );
  }
}
