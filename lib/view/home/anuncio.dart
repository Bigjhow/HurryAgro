//---- Packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hurryAgro/view/chat/chat.dart';

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
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width* 1,
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
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
              Container(
                padding: EdgeInsets.all(10),
                margin: const EdgeInsets.all(10.0),
                child: Text(
                  "Descrição: " + widget.descricao,
                  style: (styleTextDescribe),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.07,
                child: RaisedButton.icon(
                    color: Colors.green,
                    icon: Icon(Icons.chat),
                    label: Text("Chat"),
                    onPressed: () {
                      
                    }),
              ),
            ],
          ),
        )));
  }
}
