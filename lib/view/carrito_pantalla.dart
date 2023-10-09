import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectomovil/model/Carrito.dart';

class PantallaCarrito extends StatefulWidget {
  @override
  _PantallaCarritoState createState() => _PantallaCarritoState();
}

class _PantallaCarritoState extends State<PantallaCarrito> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Carrito>(builder: (context, carrito, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Pedidos"),
          backgroundColor: Colors.amber,
          elevation: 0,
        ),
        body: Container(
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
                          Expanded(child: Text("Total")),
                          Text("SubTotal: "),
                          Text("Bs " + carrito.montoTotal.toString()),
                        ],
                      ),
                    )
                  ],
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.red,
          child: Icon(
            Icons.send,
            color: Colors.amberAccent,
          ),
        ),
      );
    });
  }
}
