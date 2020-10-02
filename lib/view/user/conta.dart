import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hurryAgro/auth/login.dart';
import 'package:hurryAgro/view/user/meusAnuncios.dart';

class Conta extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Conta> {
  @override
  Widget build(BuildContext context) {
    var textBase = TextStyle(fontSize: 20);

    return Scaffold(     
      appBar: AppBar(
        title: SizedBox(
              width:55,
              height:55,
              child: Image.asset("imagens/logoNome.png")
            ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,     
        body: SingleChildScrollView( 
          child: Column(                
            children: <Widget> [
              Container(  
                  padding: const EdgeInsets.only(top: 10,left: 50, right: 50),          
                  child: Center(     
                    child: Icon(
                      Icons.account_circle,
                      size: 75,
                    ),
                  ),              
              ),              
              Container(
                margin: const EdgeInsets.all(3.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  children: <Widget> [
                    Row(             
                      children: <Widget> [
                        Text(
                          "Nome: João Pedro Lima",
                          style: textBase,                      
                        ),
                      ],
                    ),
                    Row(             
                      children: <Widget> [
                        Text(
                          "E-mail:jpLima@gmail.com",
                           style: textBase,                           
                        ),
                      ],
                    ),
                    Row(             
                      children: <Widget> [
                        Text(
                          "Localização:Itapeva - SP",
                           style: textBase,                           
                        ),
                      ],
                    ),
                    Row(             
                      children: <Widget> [
                        Text(
                          "Reputação:",
                           style: textBase,                          
                        ),
                      ],
                    ),
                  ],
                ),
        
              ),
            ],
          ),
        ),
    );
  }
}
