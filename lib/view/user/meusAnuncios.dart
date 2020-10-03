//---- Packages
import 'package:flutter/material.dart';

//---- Datas
import 'package:hurryAgro/data/data.dart';

class MeusAnuncios extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MeusAnuncios> {
  Future getDados() async {
    print("Recaregado");
    return anuncios;
  }

  var produtoApagado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: getDados(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
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
                            return Dismissible(
                                direction: DismissDirection.startToEnd,
                                background: Container(
                                  color: Colors.red,
                                  child: Align(
                                      alignment: Alignment(-0.9, 0),
                                      child: Icon(Icons.delete,
                                          color: Colors.white)),
                                ),
                                onDismissed: (d) {
                                  produtoApagado = anuncios[index];
                                  setState(() {
                                    anuncios.removeAt(index);
                                  });
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("O Produto: " +
                                        produtoApagado["name"] +
                                        " foi excluido"),
                                    action: SnackBarAction(
                                        label: "Desfazer",
                                        onPressed: () {
                                          setState(() {
                                            anuncios.insert(
                                                index, produtoApagado);
                                          });
                                        }),
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.white,
                                  ));
                                },
                                key: Key(DateTime.now().toString()),
                                child: GestureDetector(
                                    onTap: () => {},
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(120),
                                        child: Card(
                                            child: ListTile(
                                          title: Text(anuncios[index]["name"]),
                                          subtitle: Text(
                                              "R\$${anuncios[index]["price"]}"),
                                          leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                              anuncios[index]["image"],
                                              width: 80,
                                              height: 80,
                                            ),
                                          ),
                                          trailing: IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                setState(() {
                                                  anuncios.removeAt(index);
                                                });
                                              }),
                                        )))));
                          },
                        ))
                  ])),
                  onRefresh: () => getDados());
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
