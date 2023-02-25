import 'package:flutter/material.dart';

class Favoritos extends StatefulWidget {
  const Favoritos({super.key});

  @override
  State<Favoritos> createState() => _HomeState();
}

class _HomeState extends State<Favoritos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Favoritos Puto'),
    );
  }
}
