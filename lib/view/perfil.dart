import 'package:flutter/material.dart';
import 'package:proyectomovil/model/modelPersona.dart';
import 'package:proyectomovil/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:proyectomovil/view/inicio_botones.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PantallaPerfil extends StatefulWidget {
  final String idUsuario;

  const PantallaPerfil({Key? key, required this.idUsuario}) : super(key: key);

  @override
  State<PantallaPerfil> createState() => _PantallaPerfilState();
}

class _PantallaPerfilState extends State<PantallaPerfil> {
  Future<void> eliminarIdUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('idUsuario');
  }

  late ApiService _apiService;
  late Future<Persona> _personaFuture;

  @override
  void initState() {
    super.initState();
    _apiService =
        ApiService(Dio()); // Puedes configurar Dio según tus necesidades
    _personaFuture = _apiService.obtenerPersona(widget.idUsuario);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil', 
        style: TextStyle(
              color: Colors.white, // Cambia el color de la letra aquí
            ),
        ),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<Persona>(
        future: _personaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error al cargar la información de la persona');
          } else {
            return _buildPersonaDetails(snapshot.data!);
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                eliminarIdUsuario();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PantallaInicioBotones()));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sesión cerrada con éxito'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonaDetails(Persona persona) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Nombres', persona.nombres),
          _buildDetailRow('Apellidos', persona.apellidos),
          _buildDetailRow('Teléfono', persona.telefono),
          _buildDetailRow('CI', persona.ci),
          _buildDetailRow('Correo Electrónico', persona.correo),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
