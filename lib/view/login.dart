import 'package:flutter/material.dart';
import 'package:proyectomovil/view/registro.dart';

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({Key? key});

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Iniciar sesión"),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 300, // Ajusta la altura de la imagen según tu preferencia
              child: Image.network(
                "https://storage.googleapis.com/primerstorage/20230908_020308_logochurrasqueria.jpg",
                fit: BoxFit.cover, // Ajusta la imagen dentro del contenedor
                width: 300, // Establece el ancho de la imagen para que se expanda horizontalmente
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Correo Electrónico'),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Contraseña'),
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para iniciar sesión
                    },
                    child: Text('Iniciar Sesión'),
                  ),
                  SizedBox(height: 12.0),
                  TextButton(
                    onPressed: () {
                      // Navegar a la pantalla de creación de cuenta
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaRegistro()));
                    },
                    child: Text('Crear Cuenta'),
                  ),
                  SizedBox(height: 12.0),
                  TextButton(
                    onPressed: () {
                      // Navegar a la pantalla de recuperación de contraseña
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                    },
                    child: Text('¿Olvidaste tu contraseña?'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
