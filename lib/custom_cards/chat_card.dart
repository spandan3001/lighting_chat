import 'package:flutter/material.dart';

class ChatCard extends StatefulWidget {
  const ChatCard({super.key});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.black12,
                    size: 50,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SPANDAN",
                      style: TextStyle(fontSize: 15),
                    ),
                    Row(
                      children: [
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
            Text("yesterday"),
          ],
        ),
      ),
    );
  }
}
