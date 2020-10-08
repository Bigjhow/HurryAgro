//---- Packages
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

//---- Screens
import 'package:hurryAgro/view/home/anuncio.dart';

//---- Datas
import 'package:hurryAgro/data/data.dart';

import '../../data/data.dart';

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

  Future getDados() async {
    print("Recaregado");
    return anuncios;
  }

  Map pesquisa = {"name": null};
  List datas;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      try {
        pesquisa = widget.pesquisa;
        print("pesquisaa");
      } catch (e) {
        print(e);
      }
    });
    datas = widget.datas;
  }

  @override
  Widget build(BuildContext context) {
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
                  onPageChanged: (index, b) => print(index)),
            ),
            Container(
                width: 1000,
                height: 300,
                child: pesquisa["name"] == null
                    ? ListView.builder(
                        itemCount: datas.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Anuncio(
                                              name: datas[index]["name"],
                                              describe: datas[index]
                                                  ["describe"],
                                              price: datas[index]["price"]
                                                  .toString(),
                                              image: datas[index]["image"],
                                            )),
                                  ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(120),
                                  child: Card(
                                      child: ListTile(
                                    title: Text(datas[index]["name"]),
                                    subtitle:
                                        Text("R\$${datas[index]["price"]}"),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        datas[index]["image"],
                                        width: 80,
                                        height: 80,
                                      ),
                                    ),
                                  ))));
                        },
                      )
                    : Card(
                        child: ListTile(
                        title: Text(pesquisa["name"]),
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
}
