import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:proyecto_flutter/aplicacion/favoritos.dart';
import 'package:proyecto_flutter/aplicacion/home.dart';

class BarraLateral extends StatefulWidget {
  const BarraLateral({super.key});

  @override
  State<BarraLateral> createState() => _BarraLateralState();
}

class _BarraLateralState extends State<BarraLateral> {
  List<ScreenHiddenDrawer> paginas = [];

  @override
  void initState() {
    super.initState();

    paginas = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Home',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle(),
        ),
        Home(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Favoritos',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle(),
        ),
        Favoritos(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Cerrar Sesión',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle(),
        ),
        Favoritos(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.deepPurple,
      screens: paginas,
      initPositionSelected: 0,
    );
  }
}
