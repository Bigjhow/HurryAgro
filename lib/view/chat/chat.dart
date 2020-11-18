import 'package:flutter/material.dart';
import 'package:hurryAgro/model/message_model.dart';
import 'package:hurryAgro/view/chat/chatPv.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  Chat({Key key, this.chat}) : super(key: key);
  final Message chat;
  @override
  _ChatState createState() => _ChatState();
}

QuerySnapshot users;

Future getDados() async {
  users = await FirebaseFirestore.instance.collection('users').get();

  return await FirebaseFirestore.instance.collection('users').get();
}

class _ChatState extends State<Chat> {
  QuerySnapshot anuncios;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDados(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPv(
                                  nome: snapshot.data.docs[index]["nome"],
                                  id: snapshot.data.docs[index]["id"]
                                      .toString(),
                                  image: snapshot.data.docs[index]["image"],
                                ))),
                    child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    snapshot.data.docs[index]["image"],
                                  ),
                                  radius: 32.0,
                                ),
                                
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(snapshot.data.docs[index]["nome"],
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center),
                                ),
                              ],
                            ),
                            Divider(),
                          ],
                        )));
              },
            );
          }
        });
  }
}
