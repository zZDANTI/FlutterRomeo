// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/single_child_widget.dart';
import 'package:proyecto_flutter/aplicacion/favoritos.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class OcioDetalles extends StatefulWidget {
  final String nombre;
  final int estrellas;
  final String imagen;
  final bool corazon;
  final String ubicacion;
  final String url;
  final String descripcion;
  final int precio;
  final List comentarios;

  OcioDetalles({
    super.key,
    required this.comentarios,
    required this.nombre,
    required this.estrellas,
    required this.imagen,
    required this.corazon,
    required this.ubicacion,
    required this.url,
    required this.descripcion,
    required this.precio,
  });

  @override
  State<OcioDetalles> createState() => _OcioDetallesState();
}

class _OcioDetallesState extends State<OcioDetalles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nombre),
        flexibleSpace: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            //Icono de localizacion
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              GestureDetector(
                onTap: () async {
                  //const url = ubicacion;
                  if (await canLaunch(widget.ubicacion)) {
                    await launch(widget.ubicacion);
                  } else {
                    throw 'No se pudo lanzar';
                  }
                },
                child: Center(
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
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
            ],
          ),
          Prueba(
            estrellas: widget.estrellas,
            precio: widget.precio,
            descripcion: widget.descripcion,
            url: widget.url,
            comentarios: widget.comentarios,
          )
        ],
      ),
    );
  }
}

class Prueba extends StatelessWidget {
  final _controller = PageController();

  final String url;

  final String descripcion;

  final int precio;

  final int estrellas;

  final List comentarios;

  Prueba({
    required this.estrellas,
    required this.precio,
    required this.url,
    required this.descripcion,
    required this.comentarios,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 440,
            child: PageView(
              controller: _controller,
              children: [
                PaginaReview(
                  estrellas: estrellas,
                  precio: precio,
                  descripcion: descripcion,
                ),
                PaginaValoraciones(
                  comentarios: comentarios,
                ),
                PaginaQR(
                  url: url,
                ),
              ],
            ),
          ),
          SmoothPageIndicator(controller: _controller, count: 3)
        ],
      ),
    );
  }
}

class PaginaQR extends StatelessWidget {
  final String url;

  PaginaQR({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 40,
                ),
              ),
              Text(
                "Escanea el codigo QR para mas información",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
              ),
              QrImage(
                data: url,
                version: QrVersions.auto,
                size: 250.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaginaReview extends StatelessWidget {
  final String descripcion;
  final int precio;
  final int estrellas;

  PaginaReview({
    required this.descripcion,
    required this.precio,
    required this.estrellas,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          "Precio: " + precio.toString() + "€",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 95, top: 6),
                        height: 50,
                        child: Row(
                          children: List.generate(5, (index) {
                            if (index + 1 <= estrellas) {
                              // ignore: prefer_const_constructors

                              return Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 30,
                              );
                            } else {
                              // ignore: prefer_const_constructors
                              return Icon(
                                Icons.star_border,
                                color: Colors.amber,
                                size: 30,
                              );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      descripcion,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PaginaValoraciones extends StatelessWidget {
  final List comentarios;

  PaginaValoraciones({required this.comentarios});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.deepOrange,
          ),
        ),
      ),
    );
  }
}
