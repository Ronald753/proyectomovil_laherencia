import 'package:flutter/material.dart';
import 'package:proyectomovil/model/MenuItems.dart';
import 'package:proyectomovil/view/detalles.dart';


class PantallaMenu extends StatefulWidget {
  const PantallaMenu({Key? key});



  @override
  State<PantallaMenu> createState() => _PantallaMenuState();
}

class _PantallaMenuState extends State<PantallaMenu> {
  @override
  Widget build(BuildContext context) {
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
            _buildPlatosGrid(),
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

  Widget _buildPlatosGrid() {
    return Container(
      padding: EdgeInsets.all(5),
      child: GridView.builder(
        itemCount: platos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.5),
          crossAxisSpacing: 5,
          mainAxisSpacing: 2,
        ),
        itemBuilder: (context, index) {
          final plato = platos[index];
          return GestureDetector(
            onTap: () {
              // Navega a la pantalla de detalles del producto y pasa el objeto 'menuItems'
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PantallaDetalles(menuItems: plato), // Pasa el objeto menuItems
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
                  Image.asset("assets/img/" + (plato?.imagen ?? "")),
                  Text(plato?.nombre ?? ""),
                  Text('Bs ${plato.precio}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}