import 'package:flutter/material.dart';

class Conta extends StatefulWidget {
  @override
  _DadosState createState() => _DadosState();
}

class _DadosState extends State<Conta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Conta",
        ),
      ),
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage("imagens/diego.jpg"),
                  ),
            ListTile(
              title: Text("Diego Nogueira Marques"),
              subtitle: Text("Nome:"),
            ),
            ListTile(
              title: Text("18"),
              subtitle: Text("Idade"),
            ),
            ListTile(
              title: Text("diegoonogueiramarques@gmail.com"),
              subtitle: Text("Email"),
            ),
            ListTile(
              title: Text("(15) 997258743"),
              subtitle: Text("Telefone"),
            ),
            ListTile(
              title: Text("Nova Campina"),
              subtitle: Text("Cidade"),
            ),
          ],
        ),
      ),
    ));
  }
}
