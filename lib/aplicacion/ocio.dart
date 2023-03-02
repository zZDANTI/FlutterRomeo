// ignore_for_file: sort_child_properties_last

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_flutter/aplicacion/ocioDetalles.dart';

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

class Ocio extends StatefulWidget {
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
          return ListView(children: listado(snapshot.data, context));
        } else {
          print("No hay información");
          return Text("");
        }
      },
    ));
  }
}

List<Widget> listado(List info, context) {
  List<Widget> lista = [];
  info.forEach((elemento) {
    estrellas = elemento['estrellas'];
    var nombre = elemento['nombre'];
    var imagen = elemento['imagen'];
    var corazon = elemento['favoritos'];
    lista.add(
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OcioDetalles(
                nombre: nombre,
                estrellas: estrellas,
                corazon: corazon,
                imagen: imagen,
              ),
            ),
          );
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      onTap: () async {
                        if (corazon == "false") {
                          corazon = "true";
                        } else {
                          corazon = "false";
                        }

                        final url = Uri.parse(
                            'https://practicacampico-958ff-default-rtdb.europe-west1.firebasedatabase.app/ocio.json');
                        final response =
                            await http.patch(url, body: {"favoritos": "true"});

                        print(response.statusCode);
                        if (response.statusCode == 200) {
                          print("Ha cambiado su decision");
                        } else {
                          print("Error");
                        }
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
                children: List.generate(5, (index) {
                  if (index + 1 <= estrellas) {
                    // ignore: prefer_const_constructors
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 25,
                    );
                  } else {
                    // ignore: prefer_const_constructors
                    return Icon(
                      Icons.star_border,
                      color: Colors.amber,
                      size: 25,
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
    lista.add(Divider());
  });
  return lista;
}
