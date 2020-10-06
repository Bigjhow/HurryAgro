import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hurryAgro/auth/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_splashscreen/simple_splashscreen.dart';

class Splash extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        button = 
        Container(
          height: 40,
          width: 200,
          child: RaisedButton(
          onPressed: () {
            route();
          },
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Noto Sans JP",
            ),
          ),
          color: Colors.green,
        ),
        );
      });
      timer.cancel();
    });
  }

  Widget button = CircularProgressIndicator(
    backgroundColor: Colors.blue,
    strokeWidth: 2,
  );

  route() {
    Navigator.pushReplacement(context,
        PageTransition(child: Login(), type: PageTransitionType.bottomToTop));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(    
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Divider(),
          Container(
            child: Image.asset(
              "imagens/logo.png",
              height: 300,
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "O app Hurry Agro conta com funções como a criação de anúncios de venda, com controle total ao criador, como descrição, preço, localidade, também é possível iniciar um chat com o vendedor, para que assim negociem a venda. A HurryAgro somente dá espaço para os anunciantes, não fica apar das logísticas referente a vendas, apenas do anuncio e conversação via chat.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          button,
        ],
      )),)
      
    );
  }
}
