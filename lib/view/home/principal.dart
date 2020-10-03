//---- Packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

//---- Screens
import 'package:hurryAgro/view/home/anuncio.dart';

//---- Datas
import 'package:hurryAgro/data/data.dart';

import '../../data/data.dart';

class Principal extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: SingleChildScrollView(
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
              height: 500,
              child: ListView.builder(
                itemCount: anuncios.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Anuncio(
                                      name: anuncios[index]["name"],
                                      describe: anuncios[index]["describe"],
                                      price:
                                          anuncios[index]["price"].toString(),
                                      image: anuncios[index]["image"],
                                    )),
                          ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: Card(
                              child: ListTile(
                            title: Text(anuncios[index]["name"]),
                            subtitle: Text("R\$${anuncios[index]["price"]}"),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                anuncios[index]["image"],
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ))));
                },
              ))
        ])),
        onRefresh: () => getDados());
  }
}
