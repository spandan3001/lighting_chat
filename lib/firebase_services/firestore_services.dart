import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudService {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference<Map<String, dynamic>> userCollection =
      db.collection("users");
  static CollectionReference<Map<String, dynamic>> chatCollection =
      db.collection("chats");
  static CollectionReference<Map<String, dynamic>> messageCollection(
          String doc) =>
      chatCollection.doc(doc).collection('message');
}

class CloudStorage {
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<TaskSnapshot?> upload(File file, String imgName) async {
    try {
      TaskSnapshot taskSnapshot =
          await storage.ref("images/$imgName").putFile(file);
      return taskSnapshot;
    } catch (ex) {
      print(ex);
    }
    return null;
  }
}
