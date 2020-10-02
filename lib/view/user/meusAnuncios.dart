import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MeusAnuncios extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MeusAnuncios> {
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
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
        child: Column(
          children: <Widget>[
            Container(
                child: Text(
              "Meus Anuncios",
              style: TextStyle(
                fontSize: 30,
              ),
            )),
            Container(
              margin: const EdgeInsets.all(3.0),
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.brown,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Flexible(
                      flex: 5,
                      child: Image.network(
                        "https://www.infoescola.com/wp-content/uploads/2010/08/pepino_769056490.jpg",
                        fit: BoxFit.cover,
                        height: 100,
                      ),
                    ),
                  ),
                  Container(
                    child: Flexible(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                "Pepino",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                "RS 10,00",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Flexible(
                      flex: 2,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
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
