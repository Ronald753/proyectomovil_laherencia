import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectomovil/model/Carrito.dart';
import 'package:proyectomovil/view/inicio_botones.dart';
import 'package:proyectomovil/view/login.dart';
import 'package:proyectomovil/view/pruebaapi.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => Carrito(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'La Herencia',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: PantallaInicioBotones()
        //home: PantallaLogin(),
        //home: LoginScreen()
        //home: Recuperar(),
        );
  }
}
