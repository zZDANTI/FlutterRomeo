import 'package:flutter/material.dart';
import 'package:proyecto_flutter/pagina_principal.dart';
import 'package:firebase_core/firebase_core.dart';

// ignore_for_file: prefer_const_constructors

void main() async {
  //Conexion base de datos FireBase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //Arranca la comprobacion de login
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaginaPrincipal(),
    );
  }
}
