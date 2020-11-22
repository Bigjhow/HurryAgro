import 'package:flutter/material.dart';
import 'package:hurryAgro/view/home/carrossel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';
import 'package:hurryAgro/localData/local.dart';
import 'package:hurryAgro/Nav.dart';

import 'auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map dataUser = {"login": false, "carrousel": false};

  //---- Functions

  Future _readData() async {
    try {
      final file = await getData();
      setState(() {
        dataUser = jsonDecode(file.readAsStringSync());
      });
      print(dataUser);
      return dataUser;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _readData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hurry Agro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: "NotoSans"),
      home: dataUser["login"] == true
          ? Nav()
          : dataUser["carrousel"] == false
              ? Carrossel()
              : Login(),
    );
  }
}
