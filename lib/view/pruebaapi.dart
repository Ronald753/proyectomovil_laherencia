import 'package:flutter/material.dart';
import 'package:proyectomovil/model/modelProductos.dart';
import 'package:proyectomovil/viewmodel/apiService.dart';
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
            final List<Productos> productos = snapshot.data;
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
    return ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context,index){
          return Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Column(
              children: [
                Text(
                  productos[index].nombre ?? 'Nombre no disponible',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  productos[index].descripcion ?? 'Descripcion no disponible'
                )
              ],
            ),
          );
        },
    );
  }
}
