//---- Packages

import 'package:flutter/material.dart';
import 'package:hurryAgro/auth/cadastro.dart';
import 'package:hurryAgro/auth/esqueceuSenha.dart';
import 'package:hurryAgro/Nav.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hurryAgro/localData/local.dart';

//---- Screens
import 'cadastro.dart';

class Login extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Login> {
  bool obscureText = true;
  TextEditingController controladorEmail = TextEditingController();
  TextEditingController controladorSenha = TextEditingController();

  var textButtom = TextStyle(color: Colors.white, fontSize: 25.0);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _textoBase = "Informe seu E-mail e sua Senha";

  // _formKey = GlobalKey<FormState>();
  void _limparCampos() {
    controladorEmail.text = "";
    controladorSenha.text = "";

    setState(() {
      _textoBase = "Informe seu E-mail e sua Senha";
    });
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  Future loginEmailSenha(email, senha) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: senha);
      await saveData({
        "carrousel": true,
        'login': true,
        'image': await FirebaseAuth.instance.currentUser.photoURL,
        'nome': await FirebaseAuth.instance.currentUser.displayName,
      });
      await Navigator.pushReplacement(context,
          PageTransition(child: Nav(), type: PageTransitionType.bottomToTop));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        await showDialog(
            context: (context),
            child: AlertDialog(content: Text("Email não cadastrado")));
      } else if (e.code == "wrong-password") {
        await showDialog(
            context: (context),
            child: AlertDialog(content: Text("Senha errada")));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _limparCampos)
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
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
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            color: Colors.white,
                            child: formulario(
                                TextInputType.emailAddress,
                                "Digite seu email",
                                false,
                                Icon(
                                  Icons.email,
                                  color: Colors.green,
                                ),
                                false,
                                controladorEmail),
                          ),
                        ),
                        Divider(
                          height: 20,
                          color: Colors.green,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                                color: Colors.white,
                                child: TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: controladorSenha,
                                  obscureText: obscureText,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'senha',
                                      prefixIcon: Icon(
                                        Icons.vpn_key,
                                        color: Colors.green,
                                      ),
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.green,
                                          ),
                                          onPressed: () {
                                            print('entrada 1:$obscureText');

                                            setState(() {
                                              obscureText = !obscureText;
                                            });
                                            print('saida:$obscureText');
                                          })),
                                ))),
                        Divider(
                          height: 20,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  )),
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
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.07,
                child: RaisedButton(
                  onPressed: () async {
                    await loginEmailSenha(controladorEmail.text.trim(),
                        controladorSenha.text.trim());
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Noto Sans JP",
                    ),
                  ),
                  color: Colors.green,
                ),
              ),
              Divider(),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.07,
                child: RaisedButton(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget formulario(
      TextInputType keyBoardType,
      String hintText,
      bool obscureText,
      Icon prefixIcon,
      bool suffixIcon,
      TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: keyBoardType,
      obscureText: obscureText,
      cursorColor: Colors.green,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          fillColor: Colors.white,
          focusColor: Colors.white,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon
              ? IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    print('entrada 1:$obscureText');

                    setState(() {
                      obscureText = !obscureText;
                    });
                    print('saida:$obscureText');
                  })
              : null,
          contentPadding: EdgeInsets.all(20),
          hoverColor: Colors.white),
    );
  }
}
