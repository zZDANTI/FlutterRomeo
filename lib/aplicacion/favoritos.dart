// ignore_for_file: sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String url =
    "https://practicacampico-958ff-default-rtdb.europe-west1.firebasedatabase.app/ocio.json";

int estrellas = 0;
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

class Favoritos extends StatefulWidget {
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
      ),
    );
  }

  List<Widget> listado(List info) {
    List<Widget> lista = [];
    info.forEach((elemento) {
      estrellas = elemento['estrellas'];
      bool prueba = elemento['favoritos'];
      var corazon = elemento['favoritos'];
      var id = elemento['id'];

      if (prueba == true) {
        lista.add(
          GestureDetector(
            onDoubleTap: () {
              setState(() {
                _corazonRojo(corazon, id);
                HapticFeedback.heavyImpact();
              });
            },
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(elemento["imagen"]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    color: Colors.white.withOpacity(0.7),
                    width: 5000,
                    height: 50,
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Text(
                          elemento['nombre'],
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  bottom: 0,
                ),
                Positioned(
                  child: Container(
                    width: 380,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20)),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _corazonRojo(corazon, id);
                              HapticFeedback.heavyImpact();
                            });
                          },
                          child: Icon(
                            elemento['favoritos'] == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottom: 0,
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      for (int i = 0; i < 5; i++)
                        Icon(
                          i < estrellas ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
    return lista;
  }
}

void _corazonRojo(corazon, String id) async {
  if (corazon == false) {
    corazon = true;
  } else {
    corazon = false;
  }

  final urlj = Uri.parse(
      'https://practicacampico-958ff-default-rtdb.europe-west1.firebasedatabase.app/ocio/' +
          id +
          '.json');
  final response = await http.patch(
    urlj,
    body: jsonEncode({'favoritos': corazon}),
  );
}
