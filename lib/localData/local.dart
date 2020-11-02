import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

Future<File> getData() async {
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/data.json");
    return file;
  }

  Future saveData() async {
    final file = await getData();
    return await file.writeAsString(jsonEncode({
        'screen': "true",
        'image' : await FirebaseAuth.instance.currentUser.photoURL,
        'nome' : await FirebaseAuth.instance.currentUser.displayName,
     }));
  }