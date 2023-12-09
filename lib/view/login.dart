import 'package:flutter/material.dart';
import 'package:proyectomovil/view/inicio.dart';
import 'package:proyectomovil/view/inicio_botones.dart';
import 'package:proyectomovil/view/perfil.dart';
import 'package:proyectomovil/view/registro.dart';
import 'package:proyectomovil/service/api_service.dart';
import 'package:proyectomovil/model/modelLogin.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyectomovil/model/modelResetPass.dart';

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({Key? key});

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  late Future<String?> _idUsuarioFuture;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final apiService = ApiService(Dio());
  //final restaurarPasswordEmail = ApiService(Dio());

  @override
  void initState() {
    super.initState();
    _idUsuarioFuture = obtenerIdUsuario();
  }

  Future<String?> obtenerIdUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idUsuario');
  }

  Future<void> guardarIdUsuario(String idUsuario) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('idUsuario', idUsuario);
  }

  void _mostrarVentanaEmergente() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recuperar Contraseña'),
          content: Column(
            children: [
              Text(
                  'Por favor, introduce tu correo electrónico para restablecer la contraseña:'),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _enviarCorreoReset();
                  //Navigator.of(context).pop(); // Cerrar la ventana emergente
                },
                child: Text('Enviar Correo de Reseteo'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _enviarCorreoReset() async {
    final email = _emailController.text.trim();

    if (email.isNotEmpty) {
      try {
        //await apiService.restaurarPassword(email);

        ResetPasswordResponse response = await apiService.genResetPassLink(email);

        // Mostrar un mensaje de éxito al usuario
        print('Correo de reseteo enviado con éxito');
        
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Correo de reseteo enviado con éxito'),
        ),
      );
      } catch (e) {
        print('Error en la solicitud: $e');
        // Mostrar un mensaje de error al usuario si la solicitud falla.
      }
    } else {
      // Mostrar un mensaje indicando que el campo de correo electrónico está vacío.
      print('Ingrese un correo electronico.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ingrese un correo electronico'),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    // Verificar si los campos están vacíos
    if (email.isEmpty || password.isEmpty) {
      _mostrarMensajeError("Por favor, completa todos los campos.");
      return;
    }

    try {
      final response = await apiService.loginMovil(email, password);
      final loginResponse = LoginResponse.fromJson(response.toJson());

      if (loginResponse.status) {
        final idCliente = loginResponse.idPersona;
        guardarIdUsuario(idCliente);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PantallaInicioBotones()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Inicio de sesión con exito.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Credenciales incorrectas. Por favor, intenta de nuevo.'),
          ),
        );
      }
    } catch (error) {
      print('Error al iniciar sesión: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          //content: Text('Error al iniciar sesión. Por favor, intenta de nuevo más tarde.'),
          content:
              Text('Credenciales incorrectas. Por favor, intenta de nuevo.'),
        ),
      );
    }
  }

  void _mostrarMensajeError(String mensaje) {
    String campoFaltante = 'campo';

    if (_emailController.text.isEmpty) {
      campoFaltante = 'Correo Electrónico';
    } else if (_passwordController.text.isEmpty) {
      campoFaltante = 'Contraseña';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: campoFaltante != 'campo'
            ? Text('El campo $campoFaltante está vacío. Por favor, complétalo.')
            : Text(mensaje),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _idUsuarioFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != null) {
            return PantallaPerfil(idUsuario: snapshot.data!);
          } else {
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
                            decoration: InputDecoration(
                                labelText: 'Correo Electrónico'),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration:
                                InputDecoration(labelText: 'Contraseña'),
                          ),
                          SizedBox(height: 24.0),
                          ElevatedButton(
                            onPressed: _login,
                            child: Text('Iniciar Sesión'),
                          ),
                          SizedBox(height: 12.0),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PantallaRegistro()));
                            },
                            child: Text('Crear Cuenta'),
                          ),
                          SizedBox(height: 12.0),
                          TextButton(
                            onPressed: _mostrarVentanaEmergente,
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
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
