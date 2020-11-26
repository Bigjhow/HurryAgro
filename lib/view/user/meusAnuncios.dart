//---- Packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hurryAgro/view/user/editarAnuncio.dart';
//---- Datas

//---- Screens

class MeusAnuncios extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MeusAnuncios> {
  QuerySnapshot anuncios;

  Future getDados() async {
    anuncios = await FirebaseFirestore.instance.collection('anuncios').get();
    var idAuthor = FirebaseAuth.instance.currentUser.uid;
    return await FirebaseFirestore.instance
        .collection('anuncios')
        .where("idAuthor", isEqualTo: "$idAuthor")
        .get();
  }

  var _snack = GlobalKey<ScaffoldState>();

  var produtoApagado;

  mostrarSnack(index, text) {
    _snack.currentState.showSnackBar(SnackBar(
      content: Text("$text"),
      action: SnackBarAction(
          label: "Desfazer",
          onPressed: () {
            setState(() {});
          }),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    ));
  }
  

  Future delete() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _snack,
        appBar: AppBar(
          title: SizedBox(
              width: 55,
              height: 55,
              child: Image.asset("imagens/logoNome.png")),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder(
          future: getDados(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: RefreshIndicator(
                    child: Column(children: [
                      Divider(
                        color: Colors.white,
                      ),
                      Text(
                        'Meus Anuncios',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: Colors.green,
                      ),
                      Container(
                          width: 1000,
                          height: MediaQuery.of(context).size.height * 0.82,
                          child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            scrollDirection: Axis.vertical,
                            
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () => {},
                                  child: Container(
                                      width: 260,
                                      child: Card(
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Container(
                                                  child: Image.network(
                                                    snapshot.data.docs[index]
                                                        ["imagens"],
                                                    fit: BoxFit.cover,
                                                    filterQuality:
                                                        FilterQuality.high,
                                                    loadingBuilder: (context,
                                                        child, loading) {
                                                      return loading != null
                                                          ? LinearProgressIndicator()
                                                          : child;
                                                    },
                                                  ),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.15,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                      snapshot.data.docs[index]
                                                          ["titulo"],
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center),
                                                  Divider(
                                                    height: 45,
                                                  ),
                                                  Text(
                                                      "R\$${snapshot.data.docs[index]["preco"]}",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black38,
                                                      ),
                                                      textAlign:
                                                          TextAlign.left),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            70, 0, 0, 0),
                                                    child: IconButton(
                                                        icon: Icon(
                                                          Icons.edit,
                                                          size: 30,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => EditarAnuncio(
                                                      name:
                                                          "${snapshot.data.docs[index]["titulo"]}",
                                                      describe:
                                                          "${snapshot.data.docs[index]["descricao"]}",
                                                      price:
                                                          "${snapshot.data.docs[index]["preco"]}",
                                                      image:
                                                          "${snapshot.data.docs[index]["imagens"]}",                                                     
                                                    ))
                                          );
                                                        }),
                                                  ),
                                                  Divider(),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            70, 0, 0, 0),
                                                    child: IconButton(
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                          size: 30,
                                                        ),
                                                        onPressed: () async {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Apagar'),
                                                                  content: Text(
                                                                      'Você realmente deseja Apagar esse Anuncio?'),
                                                                  actions: [
                                                                    FlatButton(
                                                                      onPressed:
                                                                          () async {
                                                                        await Firestore
                                                                            .instance
                                                                            .collection("anuncios")
                                                                            .doc(snapshot.data.docs[index].id)
                                                                            .delete();
                                                                            Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "Sim"),
                                                                    ),
                                                                    FlatButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "Não"),
                                                                    )
                                                                  ],
                                                                );
                                                              });
                                                        }),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                        ),
                                      )));
                            },                           
                          ))
                    ]),
                    onRefresh: () => getDados()),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
