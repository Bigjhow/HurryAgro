import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hurryAgro/view/chat/chatMessage.dart';
import 'package:hurryAgro/view/chat/text_composer.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatPv extends StatefulWidget {
  ChatPv({Key key, this.id, this.nome, this.image}) : super(key: key);
  final String id;
  final String nome;
  final String image;
  @override
  _ChatPvState createState() => _ChatPvState();
}

class _ChatPvState extends State<ChatPv> {
  QuerySnapshot messages;

  bool mine;
  bool isLoading = false;
  var id = FirebaseAuth.instance.currentUser.uid;

  Future getDados() async {
    messages = await FirebaseFirestore.instance.collection('messages').get();

    return await FirebaseFirestore.instance.collection('messages').get();
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future addMessage(data) async {
    await firebaseFirestore.collection('mensagens').add({
      'data': data,
      'idSender': id,
      'time': Timestamp.now(),
    });

  }
  
  void sendMessage({String text, File imgFile}) async {
    String url = '';
    Map<String, dynamic> data = {};

    if (imgFile != null) {
      setState(() {
        isLoading = true;
      });
      var idt = DateTime.now().toString();
      try {
        await FirebaseStorage.instance.ref('photoChat/$idt').putFile(imgFile);
      } catch (e) {
        print('erro: image');
      }

      try {
        url = await FirebaseStorage.instance
            .ref('photoChat/$idt')
            .getDownloadURL();
        print(imgFile);
      } catch (e) {
        print('erro:');
      }
      data['imageUrl'] = url;
    }
    if (text != null) data['text'] = text;
    await addMessage(data);
    setState(() {
        isLoading = false;
      });
  }

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
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('mensagens')
                        .orderBy('time')
                        .snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        default:
                          List<DocumentSnapshot> documents =
                              snapshot.data.documents.reversed.toList();
                          return ListView.builder(
                              itemCount: documents.length,
                              reverse: true,
                              itemBuilder: (context, index) {
                                return chatMessage(
                                    documents[index]['data'], true);
                              });
                      }
                    })),
                    isLoading != false ? LinearProgressIndicator(): Container(),
            TextComposer(
              sendMessage,
            ),
          ],
        ));
  }
}
