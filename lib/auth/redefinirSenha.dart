import 'package:flutter/material.dart';

import 'package:hurryAgro/view/home/principal.dart';

class RedefinirSenha extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<RedefinirSenha> {
  TextEditingController controladorSenha = TextEditingController();
  TextEditingController controladorConfSenha = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _textoBase = "Informe a nova senha";

  String _senha = "";
  String _confSenha = "";

  void _limparCampos() {
    controladorSenha.text = "";
    controladorConfSenha.text = "";

    setState(() {
      _textoBase = "Informe a nova senha";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _alterarSenha() {
    setState(() {
      String _SenhaInformado = controladorSenha.text;
      String _ConfSenhaInformado = controladorConfSenha.text;

      if (_SenhaInformado == _ConfSenhaInformado) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Principal()),
        );
      } else {
        _textoBase = "As senhas não coincidem";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _limparCampos,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset("imagens/logo.png")),
              Text(
                _textoBase,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Nova Senha", labelStyle: TextStyle()),
                  
                  style: TextStyle(fontSize: 25.0),
                  controller: controladorSenha,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Informe a nova senha";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Confirmar Nova Senha",
                      labelStyle: TextStyle()),
                 
                  style: TextStyle(fontSize: 25.0),
                  controller: controladorConfSenha,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Confirme a nova senha";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: ButtonTheme(
                  minWidth: 230.0,
                  height: 40.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _alterarSenha();
                      }
                    },
                    child: Text(
                      "Concluir",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
