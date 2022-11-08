import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageStream extends StatelessWidget {
  final stream;
  final User loggedInUser = FirebaseAuth.instance.currentUser;
  MessageStream({Key key, this.stream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blueGrey,
            ),
          );
        }
        List<MessageBubble> messagesList = [];
        final messages = snapshot.data.docs.reversed;
        for (var message in messages) {
          final textMessage = (message.data() as dynamic)['text'];
          final textSender = (message.data() as dynamic)['sender'];
          final currentUser = loggedInUser.email;
          messagesList.add(
            MessageBubble(
              text: textMessage,
              sender: textSender,
              isMe: currentUser == textSender ? true : false,
            ),
          );
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            children: messagesList,
          ),
        );
      },
    );
  }
}
