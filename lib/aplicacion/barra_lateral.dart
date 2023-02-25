import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:proyecto_flutter/aplicacion/favoritos.dart';
import 'package:proyecto_flutter/aplicacion/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BarraLateral extends StatefulWidget {
  const BarraLateral({super.key});

  @override
  State<BarraLateral> createState() => _BarraLateralState();
}

class _BarraLateralState extends State<BarraLateral> {
  final user = FirebaseAuth.instance.currentUser!;
  List<ScreenHiddenDrawer> paginas = [];

  //Texto Personalizado para el navegador
  // ignore: prefer_const_constructors
  final textoPersonalizado = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();

    paginas = [
      //Cajon del menu

      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Home',
          baseStyle: textoPersonalizado,
          selectedStyle: textoPersonalizado,
          colorLineSelected: Colors.deepPurple,
        ),
        Home(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Favoritos',
          baseStyle: textoPersonalizado,
          selectedStyle: textoPersonalizado,
          colorLineSelected: Colors.deepPurple,
        ),
        Favoritos(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Cerrar Sesión',
          baseStyle: textoPersonalizado,
          selectedStyle: textoPersonalizado,
          colorLineSelected: Colors.deepPurple,
        ),
        FirebaseAuth.instance.signOut() as Widget,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.deepPurple,
      screens: paginas,
      initPositionSelected: 0,
      slidePercent: 40,
    );
  }
}
