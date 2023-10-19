import 'package:flutter/material.dart';
import 'package:proyectomovil/model/pruebacategorias.dart';

class PruebaApi extends StatefulWidget {
  const PruebaApi({Key? key});

  @override
  State<PruebaApi> createState() => _PruebaApiState();
}

class _PruebaApiState extends State<PruebaApi> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categoriasPrueba.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Categorías'),
          bottom: TabBar(
            tabs: categoriasPrueba.map((categoria) {
              return Tab(
                child: Text(categoria.nombre ?? 'Sin nombre'),
              );
            }).toList(),
            isScrollable: true, // Esto permite que las pestañas sean deslizables
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - kToolbarHeight,
            child: TabBarView(
              children: categoriasPrueba.map((categoria) {
                return Center(
                  child: Text(categoria.nombre ?? 'Sin nombre'),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
