import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screen_decider/screen_decider.dart';
import 'package:flash_chat/screens/all_chats_screen.dart';
import 'package:flash_chat/screens/contact_screen.dart';
import 'package:flutter/material.dart';

import '../custom_cards/custom_tab_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

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
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.more_vert),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.pushNamed(context, ContactScreen.id);
        },
        child: Image.asset(
          'images/new_chat.png',
          height: 30,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomTabBar(
          tabController: _controller,
          tabs: const [
            Tab(
              icon: Icon(Icons.message),
            ),
            Tab(
              icon: Icon(Icons.call),
            ),
            Tab(
              icon: Icon(Icons.people),
            ),
            Tab(
              icon: Icon(Icons.circle_outlined),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          const AllChatScreen(),
          Container(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
