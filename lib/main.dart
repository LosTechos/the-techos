import 'package:flutter/material.dart';
import 'package:pantallas/routes/login.dart';

void main() {
  runApp(TechosApp());
}

class TechosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Los Techos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginTechos(),
    );
  }
}

