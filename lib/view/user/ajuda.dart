import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hurryAgro/view/ajuda/ajudaCor.dart';
import 'package:hurryAgro/view/ajuda/ajudaString.dart';


class Ajuda extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Ajuda> {
  PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20, top: 20),
              child: GestureDetector(
                child: Container(
                  child: Text(
                    'Sair',
                    style: TextStyle(
                        color: ColorSys.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                onTap: ()  {   
                  Navigator.pop(context);
                },
              )),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: <Widget>[
              makePage(
                  image: 'imagens/passoUmFundo.png',
                  title: String.passoUmTitulo,
                  content: String.passoUmConteudo),
              makePage(
                  reverse: true,
                  image: 'imagens/passoDoisFundo.png',
                  title: String.passoDoisTitulo,
                  content: String.passoDoisConteudo),
              makePage(
                  image: 'imagens/passoTresFundo.png',
                  title: String.passoTresTitulo,
                  content: String.passoTresConteudo),
                  makePage(
                  image: 'imagens/passoQuatroFundo.png',
                  title: String.passoQuatroTitulo,
                  content: String.passoQuatroConteudo),
              makePage(
                  reverse: true,
                  image: 'imagens/passoCincoFundo.png',
                  title: String.passoCincoTitulo,
                  content: String.passoCincoConteudo),
              makePage(
                  image: 'imagens/passoSeisFundo.png',
                  title: String.passoSeisTitulo,
                  content: String.passoSeisConteudo),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          )
        ],
      ),
    );
  }

  Widget makePage({image, title, content, reverse = false}) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !reverse
              ? Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(image),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )
              : SizedBox(),
          Text(
            title,
            style: TextStyle(
                color: ColorSys.primary,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorSys.gray,
                fontSize: 20,
                fontWeight: FontWeight.w400),
          ),
          reverse
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(image),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 30 : 8,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: ColorSys.secundary, borderRadius: BorderRadius.circular(5)),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 6; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}
