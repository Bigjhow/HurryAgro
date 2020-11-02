import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Nav.dart';
import 'package:hurryAgro/data/users.dart';
import 'package:hurryAgro/localData/local.dart';

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

  

  FirebaseAuth auth = FirebaseAuth.instance;

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
    setState(() async{
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
          "senha": "${controladorSenha.text}",
        });

        print("Cadastro efetuado com sucesso");
        
      } else {
        _textoBase = "Informações incorretas!!";
      }
    });
  }

  Future cadastroEmailSenha(email, senha) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: senha);

      User user = FirebaseAuth.instance.currentUser;

      await user.sendEmailVerification();
      await saveData();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Nav()),
        );

    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        setState(() {
          
        });
      } else if (e.code == "email-already-in-use") {
        
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              Divider(),
              Container(
                width: size.width * 0.8,
                height: size.height * 0.05,
                child: RaisedButton(
                  onPressed: () async{
                    await cadastroEmailSenha(
                      controladorEmail.text.trim(), controladorSenha.text.trim());
                  },
                  child: Text(
                    "Cadastrar",
                    style: styleTextButtom,
                  ),
                  color: Colors.green,
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
