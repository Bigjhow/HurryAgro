//---- Packages
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//---- Screens
import 'package:hurryAgro/view/home/anuncio.dart';

class Principal extends StatefulWidget {
  Principal({
    Key key,
    this.datas,
    this.pesquisa,
  }) : super(key: key);
  final List datas;
  final Map pesquisa;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Principal> {
  var textTitulo = TextStyle(fontSize: 20);
  var textPreco = TextStyle(fontSize: 20, color: Colors.blue);
  QuerySnapshot anuncios;
  Future getDados() async {
    anuncios = await FirebaseFirestore.instance.collection('anuncios').get();
    for (var i = 0; i < anuncios.size; i++) {
      print(anuncios.docs[i]['titulo']);
    }
    return await FirebaseFirestore.instance.collection('anuncios').get();
  }

  Map pesquisa = {"name": null};
  List datas;
  @override
  void initState() {
    super.initState();
    datas = widget.datas;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDados(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: RefreshIndicator(
                  child: Column(children: [
                    Divider(
                      color: Colors.white,
                    ),
                    Image.asset(
                      "imagens/logoNome.png",
                      height: 100,
                    ),
                    Divider(                    
                        height: 20,
                        color: Colors.green,                   
                    ),
                    Container(
                        width: 1000,
                        height: MediaQuery.of(context).size.height * 0.68,
                        child: pesquisa["name"] == null
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Anuncio(
                                                      titulo:
                                                          "${snapshot.data.docs[index]["titulo"]}",
                                                      descricao:
                                                          "${snapshot.data.docs[index]["descricao"]}",
                                                      preco:
                                                          "${snapshot.data.docs[index]["preco"]}",
                                                      image:
                                                          "${snapshot.data.docs[index]["imagens"][0]}",
                                                    )),
                                          ),
                                      child: Container(
                                          width: 260,
                                          child: Card(
                                            child: Container(
                                              
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(10),
                                                    
                                                    child:Container(
                                                      
                                                      child: Image.network(
                                                      snapshot.data.docs[index]
                                                          ["imagens"][0],
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
                                                    height: MediaQuery.of(context).size.height * 0.15,
                                                      width:  MediaQuery.of(context).size.height * 0.15,
                                                    ),                                                  
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        snapshot.data.docs[index]["titulo"],
                                                        textAlign: TextAlign.left
                                                        
                                                      ),
                                                      Divider(
                                                        height: 60,
                                                      ),
                                                      Text(
                                                        "R\$${snapshot.data.docs[index]["preco"]}",
                                                        textAlign: TextAlign.left
                                                      ),
                                                    ],
                                                  )
                                                  
                                                ],
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.15,
                                                      width:  MediaQuery.of(context).size.height * 0.15,
                                            ),
                                          )));
                                },
                                itemCount: snapshot.data.docs.length,
                              )
                            : Card(
                                child: ListTile(
                                title: Text("${pesquisa["name"]}"),
                                subtitle: Text("R\$${pesquisa["price"]}"),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    pesquisa["image"],
                                    width: 80,
                                    height: 80,
                                  ),
                                ),
                              )))
                  ]),
                  onRefresh: () => getDados()),
            );
          }
        });
  }
}
