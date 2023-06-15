import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import '../global_data.dart';

class ChatCard extends StatefulWidget {
  const ChatCard({super.key, required this.userName});

  final String userName;

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  void norOfCards(bool isCardSelected) {
    this.isCardSelected = isCardSelected;
    if (GlobalData.countOfCardSelected > 0 && isCardSelected) {
      GlobalData.countOfCardSelected++;
    } else {
      GlobalData.countOfCardSelected--;
    }
  }

  void cardUnSelect() {
    norOfCards(false);
    cardColor = Colors.transparent;
    splashColor = Colors.grey.shade400;
  }

  void cardSelect() {
    norOfCards(true);
    cardColor = Colors.grey.shade300;
    splashColor = Colors.transparent;
  }

  void isCardLongPressed() {
    if (GlobalData.countOfCardSelected > 0) {
      GlobalData.cardLongPressed = true;
    } else {
      GlobalData.cardLongPressed = false;
    }
  }

  void onTapCardSelection() {
    setState(() {
      if (GlobalData.cardLongPressed && !isCardSelected) {
        cardSelect();
      } else {
        cardUnSelect();
      }
      isCardLongPressed();
    });
  }

  void onLongPressCardSelection() {
    setState(() {
      cardSelect();
      isCardLongPressed();
    });
  }

  Color cardColor = Colors.transparent;
  Color splashColor = Colors.grey.shade400;
  bool isCardSelected = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      // onTap: () {
      //   onTapCardSelection();
      //   Navigator.pushNamed(context, ChatScreen.id);
      // },
      onLongPress: () {
        //onLongPressCardSelection();
      },
      //containedInkWell: true,
      //highlightShape: BoxShape.rectangle,
      //splashFactory: InkRipple.splashFactory,
      //splashColor: splashColor,
      onPressed: () {
        GlobalData.currentSender = widget.userName;
        Navigator.pushNamed(context, ChatScreen.id);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: const Icon(
                    Icons.account_circle,
                    color: Colors.black12,
                    size: 50,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName,
                      style: const TextStyle(fontSize: 15),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.done_all,
                          size: 20,
                          color: Colors.lightBlueAccent,
                        ),
                        SizedBox(width: 5),
                        Text('hello'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Text("yesterday"),
          ],
        ),
      ),
    );
  }
}
