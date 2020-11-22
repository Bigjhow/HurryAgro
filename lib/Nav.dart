//---- Packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hurryAgro/view/chat/chat.dart';
import 'package:hurryAgro/view/user/conta.dart';
import 'package:hurryAgro/view/user/meusAnuncios.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hurryAgro/model/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

//---- Screens
import 'package:hurryAgro/view/home/principal.dart';
import 'package:hurryAgro/view/sobre.dart';
import 'package:hurryAgro/view/home/criarAnuncio.dart';
import 'package:hurryAgro/auth/login.dart';
import 'package:hurryAgro/view/desenvolvedores.dart';

import 'localData/local.dart';

class Nav extends StatefulWidget {
  Nav({Key key, this.email, this.senha, this.image}) : super(key: key);
  final String email;
  final String senha;
  final String image;
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _index = 0;
  Map anuncio = {"name": null};
  Message chat;
  TextEditingController _searchController = TextEditingController();
  QuerySnapshot user;

  Future getDados() async {
    user = await FirebaseFirestore.instance.collection('users').get();
    var idAt = FirebaseAuth.instance.currentUser.uid;
    return await FirebaseFirestore.instance
        .collection('users')
        .where("id", isEqualTo: "$idAt")
        .get();
  }

  void makeRoutePage({BuildContext context, Widget pageRef}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => pageRef),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: Drawer(
          child: ListView(children: [
            DrawerHeader(
              child: FutureBuilder(
                  future: getDados(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(200.0),
                        child: Image.network(
                          snapshot.data.docs[0]["image"],
                          loadingBuilder: (context, child, loading) {
                            return loading != null
                                ? LinearProgressIndicator()
                                : child;
                          },
                        ),
                      );
                    }
                  }),
            ),
            ListTile(
                title: Text("Conta"),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Conta()),
                    ),
                leading: Icon(Icons.person)),
            ListTile(
                title: Text("Meus Anuncios"),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MeusAnuncios()),
                    ),
                leading: Icon(Icons.list)),
            ListTile(
                title: Text("Desenvolveres"),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Desenvolvedores()),
                    ),
                leading: Icon(Icons.group)),
            ListTile(
                title: Text("Sobre"),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Sobre()),
                    ),
                leading: Icon(Icons.info)),
            ListTile(
              title: Text("Sair"),
              onTap: () => {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Sair'),
                        content: Text('Você realmente deseja sair?'),
                        actions: [
                          FlatButton(
                            onPressed: () async {
                              makeRoutePage(context: context, pageRef: Login());
                              final file = await getData();
                              print(file.readAsString());
                              await file.writeAsStringSync(
                                  jsonEncode({"carrousel": true}));
                              await FirebaseAuth.instance.signOut();
                              print(await file.readAsString());
                            },
                            child: Text("Sim"),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Não"),
                          )
                        ],
                      );
                    }),
              },
              leading: Icon(Icons.exit_to_app),
            ),
          ]),
        ),
        appBar: AppBar(
          title: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: size.width * 0.8,
              height: size.height * 0.05,
              child: TextField(
                controller: _searchController,
                onSubmitted: (value) {
                  print('clicado');
                },
                showCursor: true,
                strutStyle: StrutStyle(leading: 0.4),
                keyboardType: TextInputType.text,
                cursorColor: Colors.green[900],
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Pesquise aqui",
                  prefixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        _searchController.clear();
                      }),
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        print('clicado');
                      }),
                ),
              ),
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
        ),
        body: _index == 0
            ? Principal(
                datas: [{}],
                pesquisa: anuncio,
              )
            : Chat(chat: chat),
        floatingActionButton: _index == 0
            ? FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => Navigator.push(
                    context,
                    PageTransition(
                        child: CriarAnuncio(),
                        type: PageTransitionType.rightToLeft)),
                backgroundColor: Colors.green)
            : null,
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                activeIcon: Icon(Icons.home, color: Colors.green)),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: "Chat",
                activeIcon: Icon(Icons.chat, color: Colors.green)),
          ],
          onTap: (i) {
            setState(() {
              _index = i;
            });
          },
          currentIndex: _index,
        ));
  }
}
