import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/input_box.dart';
import 'package:flash_chat/message_stream.dart';

import '../global_data.dart';

class ChatScreen extends StatefulWidget {
  static const id = 'chat_screen';

  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  late String textMessage;
  final _firebaseFirestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  getCurrentUser(User loggedInUser) async {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  }

  Future<Stream<QuerySnapshot<Object?>>?> getMessages() async {
    Stream<QuerySnapshot<Object?>>? stream;
    final collection = _firebaseFirestore
        .collection('chats')
        .where('userName1', isEqualTo: 'pavan')
        .where('userName2', isEqualTo: 'spandan')
        .get();
    await collection.then((value) async {
      for (var element in value.docs) {
        GlobalData.currentChat = _firebaseFirestore
            .collection('chats')
            .doc(element.id)
            .collection('message');
        stream = GlobalData.currentChat.orderBy('timeStamp').snapshots();
      }
    });
    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leadingWidth: 70,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              const Icon(Icons.arrow_back),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: const Icon(
                  Icons.account_circle,
                  size: 40,
                  color: Colors.black12,
                ),
              ),
            ],
          ),
        ),
        titleSpacing: 0,
        title: Text(GlobalData.currentSender),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FutureBuilder(
              future: getMessages(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MessageStream(
                    stream: snapshot.data,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            InputMessage(
              controller: messageController,
              onPressed: () {
                if (messageController.text.trim().isNotEmpty) {
                  GlobalData.currentChat.add(
                    {
                      'text': messageController.text.trim(),
                      'sender': GlobalData.userName,
                      'timeStamp': FieldValue.serverTimestamp()
                    },
                  );
                }
                messageController.clear();
              },
            )
          ],
        ),
      ),
    );
  }
}
