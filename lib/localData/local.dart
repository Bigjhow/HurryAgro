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

Future saveData(Map object) async {
  final file = await getData();
  await file.writeAsStringSync(jsonEncode(object));
  print(await file.readAsString());
}
