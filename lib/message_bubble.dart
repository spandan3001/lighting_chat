import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      this.text,
      this.sender,
      this.isMe = false,
      required this.time});

  final String? text;
  final String? sender;
  final String? time;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      backGroundColor: isMe ? kCardColor : Colors.white,
      margin: isMe
          ? const EdgeInsets.only(top: 10, bottom: 10, left: 20)
          : const EdgeInsets.only(top: 10, bottom: 10, right: 20),
      //padding: const EdgeInsets.symmetric(horizontal: 5),
      clipper: isMe
          ? ChatBubbleClipper1(type: BubbleType.sendBubble)
          : ChatBubbleClipper1(type: BubbleType.receiverBubble),
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(
          minHeight: 20,
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                text!,
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            const SizedBox(width: 5),
            Text(
              time!,
              style: const TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
