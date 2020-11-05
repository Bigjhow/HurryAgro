import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sobre extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
        color: Colors.green, fontSize: 17, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          
        ),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
          child: Column(children: <Widget>[
            SizedBox(
                width: 300,
                height: 300,
                child: Image.asset("imagens/logo.png")),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(7.0),
              decoration: BoxDecoration(),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "    Visando a facilitação do comercio da área agrícola, foi desenvolvida uma plataforma livre para que todos possam fazer proveito. A HurryAgro conta com funções como a criação de anúncios de venda, com controle total ao criador, como descrição, preço, localidade, também é possível iniciar um chat com o vendedor, para que assim negociem a venda. A HurryAgro somente dá espaço para os anunciantes, não fica apar das logísticas referente a vendas, apenas do anuncio e conversação via chat.",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ])
          ),
    );
  }
}
