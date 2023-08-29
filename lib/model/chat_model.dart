import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String id;
  final String user1;
  final String user2;
  //final List<MessageModel>? message;

  const ChatModel({
    required this.user1,
    required this.user2,
    required this.id,
  });

  factory ChatModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ChatModel(
      id: document.id,
      user1: data['user1'],
      user2: data['user2'],
    );
  }
}
