import 'package:flash_chat/model/message_model.dart';
import 'package:flash_chat/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'message_bubble.dart';
import 'model/user_model.dart';

class MessageStream extends StatelessWidget {
  const MessageStream({
    Key? key,
    required this.chats,
  }) : super(key: key);

  final List<MessageModel> chats;

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).getUser();
    List<MessageBubble> messagesList = List.generate(
      chats.length,
      (index) => MessageBubble(
        msgModel: chats[index],
        isMe: userModel.email == chats[index].withUser ? true : false,
      ),
    );
    return ListView.builder(
      reverse: true,
      itemCount: messagesList.length,
      itemBuilder: (context, index) => messagesList[index],
    );
  }
}
