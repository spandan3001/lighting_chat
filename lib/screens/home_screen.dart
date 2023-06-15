import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screen_decider/screen_decider.dart';
import 'package:flutter/material.dart';

import '../custom_cards/chat_card.dart';
import '../custom_cards/custom_bottom_app_bar.dart';
import '../global_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          titleSpacing: 5,
          title: const Text('LightChat'),
          backgroundColor: kPrimaryColor,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushNamedAndRemoveUntil(
              context, ScreenDecider.id, (route) => false);
        },
        child: Image.asset(
          'images/new_chat.png',
          height: 30,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
      body: SizedBox(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('chats').snapshots(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blueGrey,
                ),
              );
            }
            List<ChatCard> messagesList = [];
            final users = snapshot.data?.docs;
            var sender = "";
            var receiver = "";
            for (var user in users!) {
              sender = user.data()['userName1'];
              receiver = user.data()['userName2'];
              if (sender == GlobalData.userName) {
                sender = user.data()['userName2'];
                receiver = user.data()['userName2'];
              }
              messagesList.add(
                ChatCard(userName: sender),
              );
            }
            return Expanded(
              child: ListView(
                children: messagesList,
              ),
            );
          },
        ),
      ),
    );
  }
}
