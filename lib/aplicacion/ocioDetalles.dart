// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_flutter/aplicacion/favoritos.dart';

class OcioDetalles extends StatefulWidget {
  final String nombre;
  final int estrellas;
  final String imagen;
  final bool corazon;

  OcioDetalles(
      {super.key,
      required this.nombre,
      required this.estrellas,
      required this.imagen,
      required this.corazon});

  @override
  State<OcioDetalles> createState() => _OcioDetallesState();
}

class _OcioDetallesState extends State<OcioDetalles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nombre),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.imagen),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            // ignore: sort_child_properties_last
            child: Container(
              width: 380,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: EdgeInsets.only(left: 20)),
                  InkWell(
                    child: Icon(
                      widget.corazon == true
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
    );
  }
}
