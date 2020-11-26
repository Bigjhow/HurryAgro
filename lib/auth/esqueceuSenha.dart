//---- Packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//---- Screens

class EsqueceuSenha extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<EsqueceuSenha> {
  TextEditingController controladorEmail = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  var textButtom = TextStyle(color: Colors.white, fontSize: 25.0);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _textoBase = "Informe seu E-mail";

  bool obscureText = true;

  // _formKey = GlobalKey<FormState>();
  void _limparCampos() {
    controladorEmail.text = "";

    setState(() {
      _textoBase = "Informe seu E-mail";
    });
  }

  Future sendPasswordResetEmail(String email) async {
    try{
       await auth.sendPasswordResetEmail(email: email);     
       await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Redefinir denha'),
                        content: Text('foi mandado um email de redefinir a senha para $email'),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Ok"),
                          )
                        ],
                      );
                    });
        return Navigator.pop(context);            
    }catch (e) {  
        if (e.code == "user-not-found") {
        await showDialog(
            context: (context),
            child: AlertDialog(content: Text("Email não cadastrado")));
      }       
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
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
formulario(
                false,
                "Email",
                TextInputType.emailAddress,
                controladorEmail,
                "Informe o Email",
              ),
              Divider(),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.07,
                child: RaisedButton(
                  onPressed: () async{
                    await sendPasswordResetEmail(controladorEmail.text.trim());
                  },
                  child: Text(
                    "Trocar de senha",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Noto Sans JP",
                    ),
                  ),
                  color: Colors.green,
                ),
              ),
                  ],
                )
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
