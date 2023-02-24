import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginPagina();
}

class _LoginPagina extends State<Login> {
  //Texto Controlador

  final emailLogin = TextEditingController();
  final contrasenyaLogin = TextEditingController();

  Future iniciaSesion() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailLogin.text.trim(),
      password: contrasenyaLogin.text.trim(),
    );
  }

  @override
  void dispose() {
    emailLogin.dispose();
    contrasenyaLogin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //Hola
            Text('Hotel Romeo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                )),

            Text('Bienvenido',
                style: TextStyle(
                  fontSize: 20,
                )),
            SizedBox(height: 20),

            //Texto Email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    //Variable
                    controller: emailLogin,

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  ),
                ),
              ),
            ),

            //Texto Contraseña

            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    //Variable
                    controller: contrasenyaLogin,

                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Contraseña',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Boton de inicio Sesion

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: iniciaSesion,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            // No te has registrado

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '¿Aun no te has registrado? ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Registrate aqui',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ]),
        ),
      )),
    );
  }
}
