import 'package:flutter/material.dart';
import 'package:hurryAgro/auth/redefinirSenha.dart';

class ReceberCodigo extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<ReceberCodigo> {
  TextEditingController controladorCodigo = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _textoBase = "Informe o código enviado ao seu email";

  String _codigo = "12345";

  void _limparCampos() {
    controladorCodigo.text = "";

    setState(() {
      _textoBase = "Informe o código enviado ao seu email";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _recuperarSenha() {
    setState(() {
      String _codigoInformado = controladorCodigo.text;

      if (_codigoInformado == _codigo) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RedefinirSenha()),
        );
      } else {
        _textoBase = "Código incorreto!!";
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
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Código", labelStyle: TextStyle()),
                  style: TextStyle(fontSize: 25.0),
                  controller: controladorCodigo,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Informe o código";
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
                        _recuperarSenha();
                      }
                    },
                    child: Text(
                      "Verificar",
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
