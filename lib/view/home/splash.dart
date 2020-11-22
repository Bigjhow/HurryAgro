import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hurryAgro/auth/login.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:hurryAgro/localData/local.dart';
import 'package:hurryAgro/Nav.dart';
import 'package:hurryAgro/view/home/carrossel.dart';

class Splash extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Splash> {

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
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        route();
      });
      timer.cancel();
    });
  }

  route() {
    Navigator.pushReplacement(context,
        PageTransition(child: dataUser["login"] == true
          ? Nav()
          : dataUser["carrousel"] == false
              ? Carrossel()
              : Login(), type: PageTransitionType.bottomToTop));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child:
            Image.asset(
                      "imagens/logo.png",
                      width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.35,
                    ),
      ),
    );
  }
}
