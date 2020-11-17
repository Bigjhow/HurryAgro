import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hurryAgro/localData/local.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Cadastro extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Cadastro> {
  bool obscureText = false;
  File sampleImage;
  String imageUser = '';
  bool _isChecked = false;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUser = tempImage.path;
    });
    print(imageUser);
  }

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

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future addUser(id, nome, email, senha, imageUser) async {
    await firebaseFirestore.collection('users').add({
      'id': id,
      'nome': '$nome',
      'email': '$email',
      'senha': '$senha',
      'image': imageUser,
    });
  }

  Future cadastroEmailSenha(email, senha) async {
    String _nomeInformado = controladorNome.text;
    String _emailInformado = controladorEmail.text;
    String _senhaInformado = controladorSenha.text;
    String _confSenhaInformado = controladorConfSenha.text;

    if (_nomeInformado != "" &&
        _emailInformado != "" &&
        _senhaInformado != "" &&
        _confSenhaInformado != "" &&
        _senhaInformado == _confSenhaInformado) {
      try {
        await auth.createUserWithEmailAndPassword(
            email: email, password: senha);

        User user = FirebaseAuth.instance.currentUser;

        await user.sendEmailVerification();
        await saveData();
        var id = FirebaseAuth.instance.currentUser.uid;

        try {
          await FirebaseStorage.instance
              .ref('photoUsers/$id')
              .putFile(File(imageUser));
        } catch (e) {
          print('erro: image');
        }

        try {
          imageUser = await FirebaseStorage.instance
              .ref('photoUsers/$id')
              .getDownloadURL();
          print(imageUser);
        } catch (e) {
          print('erro:');
        }

        await addUser(
            id, _nomeInformado, _emailInformado, _senhaInformado, imageUser);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Nav()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          setState(() {});
        } else if (e.code == "email-already-in-use") {
          await showDialog(
              context: (context),
              child: AlertDialog(content: Text("Email ja cadastrado")));
        }
      } catch (e) {
        print(e);
      }
    } else {
      await showDialog(
          context: (context),
          child: AlertDialog(content: Text("Informações incorretas")));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SizedBox(
            width: 55, height: 55, child: Image.asset("imagens/logoNome.png")),
        centerTitle: true,
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
              Text(
                _textoBase,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 18.0),
              ),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(children: [
                    GestureDetector(
                      onTap: () => {
                        getImage(),
                      },
                      child: Container(
                        width: 150.0,
                        height: 150.0,
                        child: imageUser == ''
                            ? Center(
                                child: Icon(
                                  Icons.photo_camera,
                                  size: 50,
                                  color: Colors.black38,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(70.0),
                                child: Image.file(
                                  File(imageUser),
                                  fit: BoxFit.cover,
                                )),
                        decoration: new BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    formulario(false, "Nome", TextInputType.name,
                        controladorNome, "Nome vazio"),
                    formulario(false, "Email", TextInputType.text,
                        controladorEmail, "Email vazio"),
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
                      width: MediaQuery.of(context).size.width * 0.90,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: RaisedButton(
                        onPressed: () async {
                          await cadastroEmailSenha(controladorEmail.text.trim(),
                              controladorSenha.text.trim());
                        },
                        child: Text(
                          "Cadastrar",
                          style: styleTextButtom,
                        ),
                        color: Colors.green,
                      ),
                    ),
                  ])),
              //TextFormField
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
