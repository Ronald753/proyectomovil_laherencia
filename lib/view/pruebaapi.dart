import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:proyectomovil/service/api_service.dart';

class Recuperar extends StatefulWidget {
  @override
  _RecuperarState createState() => _RecuperarState();
}

class _RecuperarState extends State<Recuperar> {
  final Dio dio = Dio(); // Puedes configurar Dio según tus necesidades
  final restaurarPasswordEmail = ApiService(Dio()); // La interfaz para el servicio de reseteo de contraseña

  TextEditingController emailController = TextEditingController();

  void sendResetPasswordEmail() async {
    final email = emailController.text.trim();

    if (email.isNotEmpty) {
      try {
        await restaurarPasswordEmail.restaurarPassword(email);

        // Mostrar un mensaje de éxito al usuario
        print('Correo de reseteo enviado con éxito.');
      } catch (e) {
        print('Error en la solicitud: $e');
        // Mostrar un mensaje de error al usuario si la solicitud falla.
      }
    } else {
      // Mostrar un mensaje indicando que el campo de correo electrónico está vacío.
      print('Ingrese un correo electronico');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                sendResetPasswordEmail();
              },
              child: Text('Enviar Correo de Reseteo'),
            ),
          ],
        ),
      ),
    );
  }
}
