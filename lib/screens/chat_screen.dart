import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/input_box.dart';
import 'package:flash_chat/message_stream.dart';

class ChatScreen extends StatefulWidget {
  static const id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  String textMessage;
  final _firebaseFirestore = FirebaseFirestore.instance;
  final User loggedInUser = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser(loggedInUser);
  }

  getCurrentUser(User loggedInUser) async {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      print(loggedInUser.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(
              /*stream: _firebaseFirestore
                  .collection('messages')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),*/
              stream: _firebaseFirestore
                  .collection('messages')
                  .orderBy('Timestamp')
                  .snapshots(),
            ),
            InputMessage(
              controller: messageController,
              onChanged: (value) {
                textMessage = value;
              },
              onPressed: () {
                messageController.clear();
                _firebaseFirestore.collection('messages').add(
                  {
                    'text': textMessage,
                    'sender': loggedInUser.email,
                    'Timestamp': FieldValue.serverTimestamp()
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
