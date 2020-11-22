import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class Conta extends StatefulWidget {
  @override
  _DadosState createState() => _DadosState();
}

class _DadosState extends State<Conta> {
  QuerySnapshot user;
  Future getDados() async {
    user = await FirebaseFirestore.instance.collection('users').get();
    var idAt = FirebaseAuth.instance.currentUser.uid;
    return await FirebaseFirestore.instance
        .collection('users')
        .where("id", isEqualTo: "$idAt")
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Conta",
        ),
      ),
      body: FutureBuilder(
          future: getDados(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(1000.0),
                        child: Image.network(
                          snapshot.data.docs[0]["image"],
                          loadingBuilder: (context, child, loading) {
                            return loading != null
                                ? LinearProgressIndicator()
                                : child;
                          },
                          width: 300,
                          height: 300,
                        ),
                      ),
                      ListTile(
                        title: Text(snapshot.data.docs[0]["nome"],),
                        subtitle: Text("Nome:"),
                      ),
                      ListTile(
                        title: Text(snapshot.data.docs[0]["email"],),
                        subtitle: Text("Email"),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
