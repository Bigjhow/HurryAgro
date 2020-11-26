import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
//---- Datas
import 'package:image_picker/image_picker.dart';

class EditarAnuncio extends StatefulWidget {
  EditarAnuncio({Key key, this.name, this.describe, this.image, this.price, this.idProduct})
      : super(key: key);
  final String name;
  final String describe;
  final String image;
  final String price;
  final String idProduct;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<EditarAnuncio> {
  TextEditingController controladorName;
  TextEditingController controladorPrice;
  TextEditingController controladorDescribe;
  TextEditingController controladorImage;



   String imageProduct = '';

   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future attAnuncio(idAuthor, id, titulo, descricao, preco, imageProduct) async {
    try{
      await firebaseFirestore.collection('anuncios').doc('${widget.idProduct}').update({
      'idAuthor': idAuthor,
      'id': id,
      'titulo': '$titulo',
      'descricao': '$descricao',
      'preco': '$preco',
      'imagens': imageProduct
    });
    }catch(e){
      print('deu erro aqui');
    }
    
  }


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
    String imagemInformada = controladorImage.text;
    if (tituloInformado != "" &&
        precoInformado != "" &&
        descricaoInformado != "" &&
        imagemInformada != ""
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
      
        await attAnuncio(idAuthor, id, controladorName.text, controladorDescribe.text,
          controladorPrice.text, controladorImage.text);

      Navigator.pop(context);
    } else {
      await showDialog(
          context: (context),
          child: AlertDialog(content: Text("Informações incorretas")));
    }
  }

  @override
  void initState() {

    controladorName = new TextEditingController(text: widget.name);
    controladorPrice = new TextEditingController(text: widget.price);
    controladorDescribe = new TextEditingController(text: widget.describe);
    controladorImage = new TextEditingController(text: widget.image);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
        color: Colors.green, fontSize: 17, fontWeight: FontWeight.bold);

  
   

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
            Text("Edição de Anuncio:",
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
                        child: ClipRRect(
                                child: Image.network(
                                  controladorImage.text,                               
                                )),
                        decoration: new BoxDecoration(
                          color: Colors.green,
                        ),
                      ),
                    ),
                    
            formulario(false, "Nome", TextInputType.name, controladorName,
                "Preço vazio"),
                formulario(false, "Descrição", TextInputType.text, controladorDescribe,
                "Preço vazio"),
                formulario(false, "Preço", TextInputType.number, controladorPrice,
                "Preço vazio"),
            SizedBox(
              height: 10,
            ),
            
            Container(
            child: RaisedButton(
              onPressed: () async{     
                print(widget.idProduct);
                     await verifAnuncio();  
                     
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
