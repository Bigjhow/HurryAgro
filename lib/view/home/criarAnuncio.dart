import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hurryAgro/view/home/principal.dart';

class CriarAnuncio extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<CriarAnuncio> {
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
        color: Colors.green, fontSize: 17, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
            width: 55, height: 55, child: Image.asset("imagens/logoNome.png")),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text("Criação de Anuncio:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                )),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Titulo", labelStyle: TextStyle()),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Url da foto", labelStyle: TextStyle()),
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Descrição", labelStyle: TextStyle()),
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Valor", labelStyle: TextStyle()),
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: ButtonTheme(
                minWidth: 230.0,
                height: 40.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Principal(),
                      ),
                    );
                  },
                  child: Text(
                    "Criar",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
