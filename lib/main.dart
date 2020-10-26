import 'package:flutter/material.dart';
import 'package:hurryAgro/view/home/carrossel.dart';
import 'package:firebase_core/firebase_core.dart';

void main()  async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
