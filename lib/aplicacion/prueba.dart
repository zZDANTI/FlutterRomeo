import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String url = "https://api.thecatapi.com/v1/categories";

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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Petición',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Ejemplo Future'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
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
          return Text("Sin data");
        }
      },
    ));
  }
}

List<Widget> listado(List info) {
  List<Widget> lista = [];
  info.forEach((elemento) {
    lista.add(Text(elemento["name"]));
  });
  return lista;
}
