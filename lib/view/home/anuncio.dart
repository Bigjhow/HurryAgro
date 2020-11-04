//---- Packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Anuncio extends StatefulWidget {
  Anuncio({Key key, this.titulo, this.descricao, this.image, this.preco})
      : super(key: key);
  final String titulo;
  final String descricao;
  final String image;
  final String preco;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Anuncio> {
//---- Variables

  var styleTextName = TextStyle(
    fontSize: 30,
    color: Colors.white,
  );

  var styleTextDescribe = TextStyle(fontSize: 16);

  var styleTextPrice = TextStyle(
    fontSize: 20,
    color: Colors.blueAccent,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            widget.titulo,
            style: (styleTextName),
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: <Widget>[
              Container(
                  child: Image.network(
                    widget.image,
                  ),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 3,
                    ),
                  )),
              Text(
                "Preço: R\$" + widget.preco,
                style: (styleTextPrice),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5),
                child: Text(
                  "Descrição: " + widget.descricao,
                  style: (styleTextDescribe),
                ),
              ),
              RaisedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.chat),
                  label: Text("Entrar em contato"))
            ],
          ),
        )));
  }
}
