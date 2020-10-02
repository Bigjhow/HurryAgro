import 'package:flutter/material.dart';
import 'package:hurryAgro/auth/receberCodigo.dart';

class EsqueceuSenha extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<EsqueceuSenha> {
  TextEditingController controladorEmail = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _textoBase = "Informe seu email para recuperar a senha";

  String _email = "teste@gmail.com";

  void _limparCampos() {
    controladorEmail.text = "";
    setState(() {
      _textoBase = "Informe seu email para recuperar a senha";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _esqueceuSenha() {
    setState(() {
      String _emailInformado = controladorEmail.text;

      if (_emailInformado == _email) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReceberCodigo()),
        );
      } else {
        _textoBase = "Email não cadastrado!!";
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
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "E-mail", labelStyle: TextStyle()),
                  style: TextStyle(fontSize: 25.0),
                  controller: controladorEmail,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Informe seu E-mail";
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
                        _esqueceuSenha();
                      }
                    },
                    child: Text(
                      "Receber Código",
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
