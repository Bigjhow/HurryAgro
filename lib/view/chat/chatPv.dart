import 'package:flutter/material.dart';


class ChatPv extends StatefulWidget {
  ChatPv({Key key, this.id, this.nome, this.image}) : super(key: key);
  final String id;
  final String nome;
  final String image;
  @override
  _ChatPvState createState() => _ChatPvState();
}


class _ChatPvState extends State<ChatPv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Row(
          children: [
            Container(
              child: CircleAvatar(
              backgroundImage: NetworkImage(widget.image),
              radius: 24.0,
             ),
            ),
            Container(
              padding: EdgeInsets.only(left: 8),
              child: Text(widget.nome),
              )
            
          ],
        ),
        
      ),
      body: SingleChildScrollView(),
    );
  }
}
