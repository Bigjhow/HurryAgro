//---- Packages
import 'package:flutter/material.dart';
import 'package:hurryAgro/view/chat/chat.dart';
import 'package:hurryAgro/view/user/meusAnuncios.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hurryAgro/auth/login.dart';
import 'package:hurryAgro/data/data.dart';

//---- Screens
import 'package:hurryAgro/view/home/principal.dart';
import 'package:hurryAgro/view/sobre.dart';
import 'package:hurryAgro/view/home/criarAnuncio.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _index = 0;
  Map anuncio = {"name": null};
  TextEditingController _searchController = TextEditingController();
  

  

  Future search(search) async {
    for (var x = 0; x <= anuncios.length; x++) {
      if (search == anuncios[x]["name"]) {
        print("'Chat.dart': Esse mesmo: $search");
        setState(() {
          anuncio = anuncios[x];
        });

        return anuncio;
      } else if (x == anuncio.length) {
        print("Não tem : (");
        return search;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: Drawer(
          child: ListView(children: [
            DrawerHeader(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("imagens/diego.jpg"),
              ),
            ),
            ListTile(
                title: Text("Meus Anuncios"),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MeusAnuncios()),
                    ),
                leading: Icon(Icons.list)),
            ListTile(
                title: Text("Desenvolveres"),
                onTap: () => Sobre(),
                leading: Icon(Icons.group)),
            ListTile(
                title: Text("Sobre"),
                subtitle: Text(
                  " Visando a facilitação do comercio da área agrícola, foi desenvolvida uma plataforma livre para que todos possam fazer proveito. A HurryAgro conta com funções como a criação de anúncios de venda, com controle total ao criador, como descrição, preço, localidade, também é possível iniciar um chat com o vendedor, para que assim negociem a venda. A HurryAgro somente dá espaço para os anunciantes, não fica apar das logísticas referente a vendas, apenas do anuncio e conversação via chat.",
                ),
                leading: Icon(Icons.info)),
            ListTile(
                title: Text("Sair"),
                onTap: () =>{}
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
                onChanged: (value) {
                  search(value);
                },
                showCursor: true,
                strutStyle: StrutStyle(leading: 0.4),
                keyboardType: TextInputType.text,
                cursorColor: Colors.green[900],
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Pesquise aqui",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.green,
                  ),
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.green,
                      ),
                      onPressed: () {
                       _searchController.clear();
                      }),
                ),
              ),
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
        ),
        body: _index == 0
            ? Principal(
                datas: anuncios,
                pesquisa: anuncio,
              )
            : Chat(),
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
