import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Desenvolvedores extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Desenvolvedores> {
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
            Divider(
              height: 20,
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
          ])
          ),
    );
  }
}
