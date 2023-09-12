import 'package:flutter/material.dart';
import 'package:proyectomovil/view/menu.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio"),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              "https://storage.googleapis.com/primerstorage/20230908_020308_logochurrasqueria.jpg", // Ruta de tu logo
              fit: BoxFit.fill, // Altura deseada del logo
            ),
          ],
        ),
      ),
    );
  }
}
