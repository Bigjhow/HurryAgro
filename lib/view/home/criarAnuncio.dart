import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';


//---- Datas
import 'package:firebase_auth/firebase_auth.dart';

class CriarAnuncio extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<CriarAnuncio> {
  File sampleImage;
  List images = [];


  Future getImage() async{
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState((){
      images.add(tempImage.path);
    });
    print(images[0]);
  }
  TextEditingController controladorName = TextEditingController();
  TextEditingController controladorPrice = TextEditingController();
  TextEditingController controladorDescribe = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future addAnuncio(id, titulo, descricao, preco, imagens) async{
    await firebaseFirestore.collection('anuncios').add({'id' : id, 'titulo' : '$titulo', 'descricao' : '$descricao', 'preco' : '$preco', 'imagens' : imagens});
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
            formulario(false, "Titulo", TextInputType.name, controladorName,
                "Titulo vazio"),
            formulario(false, "Preço", TextInputType.number, controladorPrice,
                "Preço vazio"),
            formulario(false, "Descrição", TextInputType.text,
                controladorDescribe, "Descrição vazio"),
            RaisedButton.icon(
                icon: Icon(Icons.camera_alt),
                label: Text("Tirar ou uma foto"),
                onPressed: () {
                  ImagePicker.platform.pickImage(source: ImageSource.camera);
                }),
                Divider(),
            RaisedButton.icon(
                icon: Icon(Icons.attach_file),
                label: Text(" Selecionar uma foto"),
                onPressed: () {
                  getImage();
                }),
                Divider(),
            RaisedButton(
              onPressed: () async{
                var id = DateTime.now().toString();
                for (var i = 0; i < 20; i++) {
                  try{
                    await FirebaseStorage.instance.ref('photoProducts/${FirebaseAuth.instance.currentUser.uid}/$id/$i').putFile(File(images[i]));
                  }catch(e){
                    print('erro:');
                  }          
                }
                List linkImages = [];
                for (var i = 0; i < 20; i++) {
                  try{
                  linkImages.add(await FirebaseStorage.instance.ref('photoProducts/${FirebaseAuth.instance.currentUser.uid}/$id/$i').getDownloadURL());
                  print(linkImages[i]);
                  }catch(e){
                    print('erro:');
                  }          
                }   
                  
                await addAnuncio(id, controladorName.text, controladorDescribe.text, controladorPrice.text, linkImages);

                Future.delayed(
                    Duration(seconds: 1), () => Navigator.pop(context));
              },
              child: Text("Criar Anúncio"),
            )
          ],
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
