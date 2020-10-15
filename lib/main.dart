import 'package:flutter/material.dart';
import 'package:hurryAgro/view/home/carrossel.dart';
import 'package:hurryAgro/view/home/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hurry Agro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: "NotoSans"),
      home: Carrossel(),
    );
  }
}
