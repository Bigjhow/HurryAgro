//---- Packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

//---- Screens
import 'package:hurryAgro/view/home/anuncio.dart';

//---- Datas
import 'package:hurryAgro/data/data.dart';

class Principal extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Principal> {
  var textTitulo = TextStyle(fontSize: 20);
  var textPreco = TextStyle(fontSize: 20, color: Colors.blue);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          height: 400,
          child: ListView.builder(
            itemCount: anuncios.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Anuncio(
                                  name: anuncios[index]["name"],
                                  price: anuncios[index]["price"],
                                  image: anuncios[index]["image"],
                                )),
                      ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: Container(
                          child: Card(
                              child: ListTile(
                        title: Text(anuncios[index]["name"]),
                        subtitle: Text("R\$${anuncios[index]["price"]}"),
                        leading: ClipRRect(
                          child: Image.asset(
                            anuncios[index]["image"],
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )))));
            },
          ))
    ]));
  }
}
