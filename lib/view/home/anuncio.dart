//---- Packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Anuncio extends StatefulWidget {
  Anuncio({Key key, this.name, this.image, this.price}) : super(key: key);
  final String name;
  final String image;
  final double price;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Anuncio> {
//---- Variables

  var textTitulo = TextStyle(
    fontSize: 30,
    color: Colors.blueAccent,
  );

  var textDescricao = TextStyle(fontSize: 16);

  var textValor = TextStyle(
    fontSize: 20,
    color: Colors.blueAccent,
  );

  var textLocalizacao = TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(widget.name),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: <Widget>[
              /*Text(
                "${widget.name}",
                style: textTitulo,
              ),*/
              Container(
                  child: Image.asset(
                    widget.image,
                    height: 200,
                  ),
                  margin: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 3,
                    ),
                  )),
              RaisedButton.icon(
                  onPressed: () {
                    /*if (_formKey.currentState.validate()) {
                        _login();
                      }*/
                  },
                  icon: Icon(Icons.chat),
                  label: Text("Entrar em contato"))
            ],
          ),
        )));
  }
}
