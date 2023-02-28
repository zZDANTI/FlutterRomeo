import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String url =
    "https://practicacampico-958ff-default-rtdb.europe-west1.firebasedatabase.app/ocio.json";

Future _getListado() async {
  Uri miUrl = Uri.parse(url);

  final respuesta = await http.get(miUrl);

  if (respuesta.statusCode == 200) {
    print(respuesta.body);
    return jsonDecode(respuesta.body);
  } else {
    print("Error con la respuesta");
  }
}

class Prueba extends StatefulWidget {
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _getListado(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot);
          return ListView(children: listado(snapshot.data));
        } else {
          print("No hay información");
          return Text("");
        }
      },
    ));
  }
}

List<Widget> listado(List info) {
  List<Widget> lista = [];
  info.forEach((elemento) {
    lista.add(Text(elemento["nombre"]));
  });
  return lista;
}
