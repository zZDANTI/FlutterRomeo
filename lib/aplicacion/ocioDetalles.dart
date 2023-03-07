// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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

  OcioDetalles({
    super.key,
    required this.nombre,
    required this.estrellas,
    required this.imagen,
    required this.corazon,
    required this.ubicacion,
    required this.url,
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
              Container(
                padding: EdgeInsets.only(right: 10),
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(5, (index) {
                    if (index + 1 <= widget.estrellas) {
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
          Prueba(
            url: widget.url,
          )
        ],
      ),
    );
  }
}

class Prueba extends StatelessWidget {
  final _controller = PageController();

  final String url;

  Prueba({required this.url});

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
                PaginaComentarios(),
                PaginaValoraciones(),
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
                style: TextStyle(fontSize: 20),
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

class PaginaComentarios extends StatelessWidget {
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
            color: Colors.red,
            child: Center(),
          ),
        ),
      ),
    );
  }
}

class PaginaValoraciones extends StatelessWidget {
  const PaginaValoraciones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(color: Colors.deepOrange),
        ),
      ),
    );
  }
}
