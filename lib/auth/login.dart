//---- Packages
import 'package:flutter/material.dart';
import 'package:hurryAgro/auth/cadastro.dart';
import 'package:hurryAgro/auth/esqueceuSenha.dart';
import 'package:hurryAgro/Nav.dart';
import 'package:hurryAgro/data/data.dart';
import 'package:page_transition/page_transition.dart';

//---- Screens
import 'cadastro.dart';

class Login extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Login> {
  TextEditingController controladorEmail = TextEditingController();
  TextEditingController controladorSenha = TextEditingController();

  var textButtom = TextStyle(color: Colors.white, fontSize: 25.0);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _textoBase = "Informe seu E-mail e sua Senha";

  String _email = "teste@gmail.com";
  String _senha = "teste";

  bool obscureText = true;

  // _formKey = GlobalKey<FormState>();
  void _limparCampos() {
    controladorEmail.text = "";
    controladorSenha.text = "";

    setState(() {
      _textoBase = "Informe seu E-mail e sua Senha";
    });
  }

  String _emailInformado;
  String _senhaInformado;

  void _login() {}

  /*void _esqueceuSenha() {
    setState(() {
      _textoBase = "Esqueceu a senha (troca de tela)";
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _limparCampos)
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset("imagens/logo.png", width: 220, height: 220),
              Text(
                _textoBase,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.orange, fontSize: 25.0),
              ),
              formulario(
                false,
                "Email",
                TextInputType.emailAddress,
                controladorEmail,
                "Informe o Email",
              ),
              formulario(true, "Senha", TextInputType.text, controladorSenha,
                  "Informe a Senha"),
              Container(
                height: 40,
                alignment: Alignment.centerRight,
                child: FlatButton(
                    child: Text(
                      "Esqueceu a Senha",
                      style: TextStyle(
                          color: Colors.blueAccent, fontFamily: "Noto Sans JP"),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            child: EsqueceuSenha(),
                            type: PageTransitionType.rightToLeft),
                      );
                    }),
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    for (var x = 0; x <= usuarios.length; x++) {
                      if (usuarios[x]["email"] == controladorEmail.text &&
                          usuarios[x]["senha"] == controladorSenha.text) {
                        return Navigator.push(
                            context,
                            PageTransition(
                                child: Nav(),
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 800))
                          
                            );
                      } else {
                        print("Email ou senha errado");
                      }
                    }
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white, fontFamily: "Noto Sans JP"),
                ),
                color: Colors.green,
              ),
              RaisedButton(
                color: Colors.green,
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Cadastro(),
                          type: PageTransitionType.rightToLeft));
                },
                child: Text(
                  "Cadastro",
                  style: TextStyle(
                    color: Colors.white,
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
