import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  final double latitude = -16.452978;
  final double longitude = -68.137123;

  void openGoogleMaps() async {
    final String googleMapsUrl =
        'https://www.google.com/maps/?q=$latitude,$longitude';
    final Uri uri = Uri.parse(googleMapsUrl);
    uri.queryParameters['app'] = 'com.google.android.apps.maps';

    final Uri mutableUri = Uri.parse(googleMapsUrl);
    mutableUri.queryParameters['app'] = 'com.google.android.apps.maps';
    await launchUrl(mutableUri);

    if (await canLaunchUrl(uri)) {
      await launch(uri.toString());
    } else {
      // No se puede abrir el navegador
      print('No se pudo abrir el navegador');
    }
  }

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
            /*
            ElevatedButton(
              onPressed: openGoogleMaps,
              child: Text("Abrir Google Maps"),
            ),*/
          ],
        ),
      ),
    );
  }
}
