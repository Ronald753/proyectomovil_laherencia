import 'package:flutter/material.dart';
import 'package:proyectomovil/view/inicio.dart';
import 'package:proyectomovil/view/menu.dart';
import 'package:proyectomovil/view/registro.dart';
import 'package:proyectomovil/service/api_service.dart';
import 'package:dio/dio.dart';

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({Key? key});
  

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final apiService = ApiService(Dio());

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final response = await apiService.login({'email': email, 'password': password});

      if (response.success) {
        // Inicio de sesión exitoso, hacer algo (por ejemplo, navegar a otra pantalla)
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PantallaInicio()));
      } else {
        // Inicio de sesión fallido, mostrar un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Credenciales incorrectas. Por favor, intenta de nuevo.'),
          ),
        );
      }
    } catch (error) {
      // Manejar errores de la solicitud, como mostrar un mensaje al usuario
      print('Error al iniciar sesión: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al iniciar sesión. Por favor, intenta de nuevo más tarde.'),
        ),
      );
    }
  }

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
              height: 300, 
              child: Image.network(
                "https://storage.googleapis.com/primerstorage/20230908_020308_logochurrasqueria.jpg",
                fit: BoxFit.cover, 
                width: 300, 
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Correo Electrónico'),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Contraseña'),
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Iniciar Sesión'),
                  ),
                  SizedBox(height: 12.0),
                  TextButton(
                    onPressed: () {
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