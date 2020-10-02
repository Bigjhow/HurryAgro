import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hurryAgro/auth/login.dart';

import 'package:hurryAgro/view/user/meusAnuncios.dart';

class Sobre extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
        color: Colors.green, fontSize: 17, fontWeight: FontWeight.bold);

    return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
        child: Column(children: <Widget>[
          SizedBox(
              width: 300, height: 300, child: Image.asset("imagens/logo.png")),
          Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(3.0),
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
          Container(
              child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("imagens/diego.jpg"),
                      ),
                      Text(
                        "Diego\n"
                        "Cursando TI",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("imagens/joao.jpg"),
                      ),
                      Text(
                        "João\n"
                        "Cursando TI",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("imagens/lorenzo.jpg"),
                      ),
                      Text(
                        "Lorenzo\n"
                        "Cursando TI",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ))
        ]));
  }
}
