import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

//---- Datas

class CriarAnuncio extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<CriarAnuncio> {
  File sampleImage;
   String imageProduct = '';
  Future getImage() async {
    try{
      var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
      imageProduct = tempImage.path;
    });
    }catch (e){
      print('erro');
    }
  }

  verifAnuncio() async {
    String tituloInformado = controladorName.text;
    String precoInformado = controladorPrice.text;
    String descricaoInformado = controladorDescribe.text;
    if (tituloInformado != "" &&
        precoInformado != "" &&
        descricaoInformado != "" &&
        imageProduct != ""
        ) {
      var id = DateTime.now().toString();
      var idAuthor = FirebaseAuth.instance.currentUser.uid;

      try {
          await FirebaseStorage.instance
              .ref('photoProducts/${FirebaseAuth.instance.currentUser.uid}/$id/')
              .putFile(File(imageProduct));
        } catch (e) {
          print('erro: image');
        }

        try {
          imageProduct = await FirebaseStorage.instance
              .ref('photoProducts/${FirebaseAuth.instance.currentUser.uid}/$id/')
              .getDownloadURL();
          print(imageProduct);
        } catch (e) {
          print('erro:');
        }
      
      

      await addAnuncio(idAuthor, id, controladorName.text, controladorDescribe.text,
          controladorPrice.text, imageProduct);

      Navigator.pop(context);
    } else {
      await showDialog(
          context: (context),
          child: AlertDialog(content: Text("Informações incorretas")));
    }
  }

  TextEditingController controladorName = TextEditingController();
  TextEditingController controladorPrice = TextEditingController();
  TextEditingController controladorDescribe = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future addAnuncio(idAuthor, id, titulo, descricao, preco, imageProduct) async {
    await firebaseFirestore.collection('anuncios').add({
      'idAuthor': idAuthor,
      'id': id,
      'titulo': '$titulo',
      'descricao': '$descricao',
      'preco': '$preco',
      'imagens': imageProduct
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
            width: 55, height: 55, child: Image.asset("imagens/logoNome.png")),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Padding(
                padding: EdgeInsets.all(10),
        child: ListView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text("Criação de Anuncio:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                )),
                Divider(),
                GestureDetector(
                      onTap: () => {
                        
                       getImage(),
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                      height: MediaQuery.of(context).size.height * 0.32,
                        child: imageProduct == ''
                            ? Center(
                                child: Icon(
                                  Icons.photo_camera,
                                  size: 50,
                                  color: Colors.black38,
                                ),
                              )
                            : ClipRRect(
                                child: Image.file(
                                  File(imageProduct),
                                  
                                )),
                        decoration: new BoxDecoration(
                          color: Colors.green,
                        ),
                      ),
                    ),
            
            formulario(false, "Titulo", TextInputType.name, controladorName,
                "Titulo vazio"),
            formulario(false, "Preço", TextInputType.number, controladorPrice,
                "Preço vazio"),
            formulario(false, "Descrição", TextInputType.text,
                controladorDescribe, "Descrição vazio"),
            Divider(),
          Container(
            child: RaisedButton(
              onPressed: () async {
                await verifAnuncio();
                print(imageProduct);
              },
              child: Text("Criar Anúncio"),
              color: Colors.green,
            ),
            width: MediaQuery.of(context).size.width * 0.90,
                      height: MediaQuery.of(context).size.height * 0.07,
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
