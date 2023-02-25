import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_flutter/login/login.dart';
import '../home.dart';

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
            return Home();
          } else {
            return Login();
          }
        },
      ),
    );
  }
}
