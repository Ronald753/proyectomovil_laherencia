import 'package:flutter/material.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({Key? key}) : super(key: key);

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _apellidos = '';
  String _telefono = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Usuario'),
        backgroundColor: Colors.amber,
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
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, introduce tu nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nombre = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Apellidos'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, introduce tus apellidos';
                  }
                  return null;
                },
                onSaved: (value) {
                  _apellidos = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, introduce tu número de teléfono';
                  }
                  return null;
                },
                onSaved: (value) {
                  _telefono = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Correo Electrónico'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value != null && value.isEmpty || !RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value ?? '')) {
                    return 'Por favor, introduce un correo electrónico válido';
                  }

                  return null;
                },
                onSaved: (value) {
                  _email = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }

                  return null;
                },
                onSaved: (value) {
                  _password = value ?? '';
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    print('Nombre: $_nombre');
                    print('Apellidos: $_apellidos');
                    print('Teléfono: $_telefono');
                    print('Correo Electrónico: $_email');
                    print('Contraseña: $_password');
                    // Resto de tu lógica aquí
                  }
                },
                child: Text('Crear Usuario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
