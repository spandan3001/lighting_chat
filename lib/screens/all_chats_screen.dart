import 'package:flash_chat/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_cards/chat_card.dart';
import '../firebase_services/firestore_services.dart';
import '../model/chat_model.dart';
import '../model/user_model.dart';
import '../user_provider.dart';

class AllChatScreen extends StatefulWidget {
  const AllChatScreen({super.key});

  @override
  State<AllChatScreen> createState() => _AllChatScreenState();
}

class _AllChatScreenState extends State<AllChatScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel userModel =
        Provider.of<UserProvider>(context, listen: false).getUser();
    return StreamBuilder(
      stream: CloudService.userCollection
          .doc(userModel.id)
          .collection('messages')
          .orderBy('timeStamp', descending: true)
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blueGrey,
            ),
          );
        }
        List<MessageModel> messageModels = snapshot.data!.docs
            .map((e) => MessageModel.fromSnapshot(e))
            .toList();
        Map<String, List<MessageModel>> chats = {};

        for (MessageModel msg in messageModels) {
          if (chats.containsKey(msg.withUser)) {
            chats[msg.withUser]!.add(msg);
          } else {
            chats.addAll({
              msg.withUser: [msg]
            });
          }
        }
        List<ChatCard> chatCards = [];
        chats.forEach((key, value) {
          chatCards.add(
            ChatCard(
              userModel: userModel,
              withUser: key,
              chats: value,
            ),
          );
        });
        return ListView(
          children: chatCards,
        );
      },
    );
  }
}
