import 'package:cloud_firestore/cloud_firestore.dart';

class GlobalData {
  static bool cardLongPressed = false;
  static int countOfCardSelected = 0;
  static String userName = "";
  static String currentSender = "";

  static CollectionReference<Map<String, dynamic>> currentChat =
      FirebaseFirestore.instance.collection('');

  void init() {
    cardLongPressed = false;
    countOfCardSelected = 0;
    userName = "";
    currentSender = "";
  }
}
