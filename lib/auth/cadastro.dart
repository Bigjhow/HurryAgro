import 'package:flutter/material.dart';
import 'package:hurryAgro/view/home/principal.dart';

import '../Nav.dart';
import 'package:hurryAgro/data/data.dart';

class Cadastro extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Cadastro> {
  TextEditingController controladorNome = TextEditingController();
  TextEditingController controladorEmail = TextEditingController();
  TextEditingController controladorSenha = TextEditingController();
  TextEditingController controladorConfSenha = TextEditingController();

  var styleTextButtom = TextStyle(color: Colors.white, fontSize: 16.0);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _textoBase = "Preencha os campos para efetuar o cadastro";

  void _limparCampos() {
    controladorNome.text = "";
    controladorEmail.text = "";
    controladorSenha.text = "";
    controladorConfSenha.text = "";

    setState(() {
      _textoBase = "Preencha os campos para efetuar o cadastro";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _cadastro() {
    setState(() {
      String _nomeInformado = controladorNome.text;
      String _emailInformado = controladorEmail.text;
      String _senhaInformado = controladorSenha.text;
      String _confSenhaInformado = controladorConfSenha.text;

      if (_nomeInformado != "" &&
          _emailInformado != "" &&
          _senhaInformado != "" &&
          _confSenhaInformado != "" &&
          _senhaInformado == _confSenhaInformado) {
            usuarios.add({
                      "email": '${controladorEmail.text}',
                      "senha": "${controladorSenha.text}"
                    });
            print("Cadastro edetuado com sucesso");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Nav()),
            );
      } else {
        _textoBase = "Informações incorretas!!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  width: 220,
                  height: 220,
                  child: Image.asset("imagens/logo.png")),
              SizedBox(
                height: 10,
              ),
              Text(
                _textoBase,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 18.0),
              ),
              //TextFormField
              formulario(false, "Nome", TextInputType.name, controladorNome,
                  "Nome vazio"),
              formulario(false, "Email", TextInputType.text, controladorEmail,
                  "Email vazio"),
              formulario(true, "Senha", TextInputType.visiblePassword,
                  controladorSenha, "Digite sua senha"),
              formulario(
                  true,
                  "Confirmar Nova Senha",
                  TextInputType.visiblePassword,
                  controladorConfSenha,
                  "senha errada"),

              RaisedButton(
                onPressed: () {
                  _cadastro();
                },
                child: Text(
                  "Cadastrar",
                  style: styleTextButtom,
                ),
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget formulario(
    bool obscureText,
    String labelText,
    TextInputType keyboardType,
    TextEditingController controller,
    String validator) {
  return TextFormField(
    keyboardType: keyboardType,
    obscureText: obscureText,
    decoration: InputDecoration(labelText: "$labelText"),
    controller: controller,
    validator: (value) {
      if (value.isEmpty) {
        return "$validator";
      }
    },
  );
}
