import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.userModel,
    required this.withUserModel,
  });

  final UserModel userModel;
  final UserModel withUserModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              userModel: userModel,
              withUser: withUserModel.email,
              withUserDocId: withUserModel.id,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          boxShadow: kElevationToShadow[1],
          borderRadius: BorderRadius.circular(2),
          color: Colors.white,
        ),
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
                      withUserModel.name,
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      withUserModel.email,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
