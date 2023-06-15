import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'global_data.dart';
import 'message_bubble.dart';

class MessageStream extends StatelessWidget {
  final Stream<QuerySnapshot<Object?>>? stream;
  const MessageStream({Key? key, this.stream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blueGrey,
            ),
          );
        }
        List<MessageBubble> messagesList = [];
        final messages = snapshot.data?.docs.reversed;
        for (var message in messages!) {
          var temp = (message.data() as dynamic);
          final textMessage = temp['text'];
          final textSender = temp['sender'];
          var timeStamp = DateTime(2023);
          if (temp['timeStamp'] != null) {
            timeStamp = temp['timeStamp'].toDate();
          }

          messagesList.add(
            MessageBubble(
              text: textMessage.trim(),
              sender: textSender,
              time: DateFormat.jm().format(timeStamp),
              isMe: GlobalData.userName == textSender ? true : false,
            ),
          );
        }
        return Expanded(
          child: ListView(
            reverse: true,
            children: messagesList,
          ),
        );
      },
    );
  }
}
