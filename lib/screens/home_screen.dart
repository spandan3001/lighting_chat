import 'package:flutter/material.dart';

import '../custom_cards/chat_card.dart';
import '../custom_cards/custom_bottom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          title: Text('LightChat'),
          backgroundColor: Color(0xFF128C7E),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.camera_alt),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(),
      body: Stack(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ChatCard();
                }),
          ),
        ],
      ),
    );
  }
}
