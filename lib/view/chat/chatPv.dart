import 'package:flutter/material.dart';

class ChatPv extends StatefulWidget {
  ChatPv({Key key, this.id, this.nome}) : super(key: key);
  final String id;
  final String nome;

  @override
  _ChatPvState createState() => _ChatPvState();
}



class _ChatPvState extends State<ChatPv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        
      ),
    );
  }
}