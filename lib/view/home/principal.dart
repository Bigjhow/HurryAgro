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
    return FutureBuilder(future: getDados(), builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(
          child: CircularProgressIndicator(),
        );
      }else if(snapshot.connectionState == ConnectionState.done){
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
            CarouselSlider(
              items: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    "https://cdn.pixabay.com/photo/2020/09/22/09/09/leaf-5592392__340.jpg",
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    "https://cdn.pixabay.com/photo/2014/11/28/00/07/mushrooms-548360__340.jpg",
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    "https://cdn.pixabay.com/photo/2020/06/05/16/53/zucchini-5263781__340.jpg",
                  ),
                ),
              ],
              options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                viewportFraction: 0.4, //Padding estre as imagens
                autoPlayCurve: Curves.ease,
                enableInfiniteScroll: true,
                height: 130,
                pauseAutoPlayOnTouch: true,
              ),
            ),
            Container(
                width: 1000,
                height: MediaQuery.of(context).size.height * 0.52,
                child: pesquisa["name"] == null
                    ?                  ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Anuncio(
                                              name: "${snapshot.data[index]["name"]}",
                                              describe:
                                                  "${snapshot.data[index]["describe"]}",
                                              price: "${snapshot.data[index]["price"]}",
                                              //image: "${snapshot.data[index]["image"]}",
                                            )),
                                  ),
                    child: Container(
                                        width: 260,
                                        child: Card(
                                          child: Column(
                                            children: [
                                              Image.network(
                                                snapshot.data.docs[index]["imagens"][0],
                                                filterQuality: FilterQuality.high,
                                                loadingBuilder: (context, child, loading){
                                                  return loading != null ? LinearProgressIndicator() : child;
                                                },
                                                fit: BoxFit.fill,
                                                height: 90,
                                              ),
                                              ListTile(
                                                title: Text(snapshot.data.docs[index]["titulo"]),
                                                trailing: Text(
                                                    "R\$" + snapshot.data.docs[index]["preco"].toString()),
                                              )
                                            ],
                                          ),
                                        ))
                );
                
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
