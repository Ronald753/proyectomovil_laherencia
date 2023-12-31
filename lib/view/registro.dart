import 'package:flutter/material.dart';
import 'package:proyectomovil/model/modelPersona.dart';
import 'package:proyectomovil/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:proyectomovil/view/inicio_botones.dart';
import 'package:proyectomovil/view/login.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({Key? key}) : super(key: key);

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final _formKey = GlobalKey<FormState>();
  final _personaService = ApiService(Dio());
  final _nombreController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _ciController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Usuario',
        style: TextStyle(
          color: Colors.white,
        ),
        ),
        backgroundColor: Colors.red,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Cédula de Identidad'),
                keyboardType: TextInputType.number,
                controller: _ciController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, introduce tu CI';
                  }
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                controller: _nombreController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, introduce tu nombre';
                  }
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Apellidos'),
                controller: _apellidosController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, introduce tus apellidos';
                  }
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                controller: _telefonoController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, introduce tu número de teléfono';
                  }
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Correo Electrónico'),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value != null && value.isEmpty || !RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value ?? '')) {
                    return 'Por favor, introduce un correo electrónico válido';
                  }
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
                obscureText: _showPassword,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }
                  if (!RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{6,}$').hasMatch(value)) {
                    return 'La contraseña debe contener números, letras y un carácter especial';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _crearPersona();
                  }
                },
                child: Text('Crear Usuario',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 147, 139) // Puedes cambiar "Colors.blue" al color que desees
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _crearPersona() async {
    // Lógica para crear la persona y hacer la llamada al servicio
    try {
      // Crear una instancia de RegistroPersonaRequest con los datos del formulario
      final registroRequest = Persona(
        nombres: _nombreController.text,
        apellidos: _apellidosController.text,
        ci: _ciController.text,
        telefono: _telefonoController.text,
        correo: _emailController.text,
        password: _passwordController.text,
      );

      // Llamada al servicio para registrar la persona
      final response = await _personaService.registrarPersona(registroRequest);

      // Manejar la respuesta del servidor según tus necesidades
      print('Respuesta del servidor: ${response.toJson()}');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cuenta creada con exito.'),
          ),
        );
      Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PantallaInicioBotones()));

      // Puedes agregar más lógica aquí, por ejemplo, mostrar un mensaje de éxito o redireccionar a otra pantalla
    } catch (e) {
      // Manejar errores, por ejemplo, mostrar un mensaje de error al usuario
      print('Error al crear la persona: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al crear la cuenta.'),
          ),
        );
    }
  }
}