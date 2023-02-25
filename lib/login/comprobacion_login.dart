import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_flutter/aplicacion/barra_lateral.dart';
import 'package:proyecto_flutter/login/login.dart';

class ComprobacionLogin extends StatelessWidget {
  const ComprobacionLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        //Si hay un usuario dentro te lleva al Principio si no vas al Login
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //Fragments de aplicacion
            return BarraLateral();
          } else {
            //Si no hay cuenta te manda al login
            return Login();
          }
        },
      ),
    );
  }
}
