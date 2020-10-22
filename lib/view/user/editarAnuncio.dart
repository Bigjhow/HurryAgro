import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hurryAgro/view/home/principal.dart';

//---- Datas
import 'package:hurryAgro/data/data.dart';
import 'package:image_picker/image_picker.dart';

class EditarAnuncio extends StatefulWidget {
  EditarAnuncio({Key key, this.name, this.describe, this.image, this.price})
      : super(key: key);
  final String name;
  final String describe;
  final String image;
  final String price;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<EditarAnuncio> {
  TextEditingController controladorName = TextEditingController();
  TextEditingController controladorPrice = TextEditingController();
  TextEditingController controladorDescribe = TextEditingController();
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
            SizedBox(
              height: 10,
            ),
            Text("Edição de Anuncio:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                )),
            formulario(false, "Titulo" + widget.name, TextInputType.name,
                controladorName, "Titulo vazio"),
            formulario(false, "Preço" + widget.price, TextInputType.number,
                controladorPrice, "Preço vazio"),
            formulario(false, "Descrição" + widget.describe, TextInputType.text,
                controladorDescribe, "Descrição vazio"),
            RaisedButton.icon(
                icon: Icon(Icons.camera_alt),
                label: Text("Tirar ou uma foto"),
                onPressed: () {
                  ImagePicker.platform.pickImage(source: ImageSource.camera);
                }),
            RaisedButton.icon(
                icon: Icon(Icons.attach_file),
                label: Text(" Selecionar uma foto"),
                onPressed: () {
                  ImagePicker.platform.pickImage(source: ImageSource.gallery);
                }),
            RaisedButton(
              onPressed: () {
                Future.delayed(
                    Duration(seconds: 1), () => Navigator.pop(context));
              },
              child: Text("Salvar Anúncio"),
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
