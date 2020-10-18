import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hurryAgro/auth/login.dart';
import 'package:page_transition/page_transition.dart';

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
        route();
      });
      timer.cancel();
    });
  }

  

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
           children: <Widget>[
             Padding(padding: EdgeInsets.only(bottom:0 ,left:20 , right:20 , top: 75)), 
          Container(
            child: Image.asset(
              "imagens/logo.png",
              height: 300,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          CircularProgressIndicator(
         backgroundColor: Colors.blue,
        strokeWidth: 3,
         ),
        ],
      ),
      ),   
      )
      
    );
  }
}
