import 'package:flash_chat/model/message_model.dart';
import 'package:flash_chat/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_cards/chat_card.dart';
import '../firebase_services/firestore_services.dart';
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
            .where('email', isNotEqualTo: userModel.email)
            .snapshots(),
        builder: (context, userSnap) {
          if (userSnap.hasData) {
            List<UserModel> userModels = userSnap.data!.docs
                .map((e) => UserModel.fromSnapshot(e))
                .toList();
            return StreamBuilder(
              stream: CloudService.userCollection
                  .doc(userModel.id)
                  .collection('messages')
                  .orderBy('timeStamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context, snapshot) {
                if (!snapshot.hasData) {
                  return const Loading();
                }
                List<MessageModel> messageModels = snapshot.data!.docs
                    .map((e) => MessageModel.fromSnapshot(e))
                    .toList();
                Map<String, MessageModel> chats = {};

                int count = 0;
                for (MessageModel msg in messageModels) {
                  if (count == userModels.length) {
                    break;
                  }
                  if (!chats.containsKey(msg.withUser)) {
                    chats.addAll({msg.withUser: msg});
                    count = count + 1;
                  }
                }

                List<ChatCard> chatCards = [];
                chats.forEach((key, value) {
                  chatCards.add(
                    ChatCard(
                      userModel: userModel,
                      withUser: key,
                      lastChat: value,
                    ),
                  );
                });
                return ListView.builder(
                  itemCount: chatCards.length,
                  itemBuilder: (context, index) => ChatCard(
                    userModel: userModel,
                    withUser: chatCards[index].withUser,
                    lastChat: chatCards[index].lastChat,
                  ),
                );
              },
            );
          } else {
            return const Loading();
          }
        });
  }
}
