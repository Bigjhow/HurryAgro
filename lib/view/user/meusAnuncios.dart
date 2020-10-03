//---- Packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

//---- Screens
import 'package:hurryAgro/view/home/anuncio.dart';

//---- Datas
import 'package:hurryAgro/data/data.dart';

import '../../data/data.dart';
import '../../data/data.dart';

class MeusAnuncios extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MeusAnuncios> {
  var textTitulo = TextStyle(fontSize: 20);
  var textPreco = TextStyle(fontSize: 20, color: Colors.blue);

  Future getDados() async {
    print("Recaregado");
    return anuncios;
  }

  @override
  Widget build(BuildContext context) {
    appBar : AppBar(
        backgroundColor: Colors.green,
      );
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
          Container(
              width: 1000,
              height: 500,
              child: ListView.builder(
                itemCount: anuncios.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () =>{},
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
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed :(){
                                anuncios.remove([index]);
                              }
                            ), 
                          ))));
                },
              ))
        ])),
        onRefresh: () => getDados());
  }
}
