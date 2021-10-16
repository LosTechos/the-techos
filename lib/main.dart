import 'package:flutter/material.dart';
import 'package:pantallas/routes/login.dart';

void main() {
  runApp(BarberApp());
}

class BarberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barber Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginBarber(),
    );
  }
}
