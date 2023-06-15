import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
        child: GNav(
          tabBackgroundColor: Colors.black12,
          color: Colors.grey,
          gap: 10,
          backgroundColor: Colors.white,
          padding: EdgeInsets.all(10),
          activeColor: kSecondaryColor,
          tabs: [
            GButton(
              icon: Icons.message,
              text: 'messages',
            ),
            GButton(
              icon: Icons.call,
              text: 'phone',
            ),
            GButton(
              icon: Icons.people,
              text: 'community',
            ),
            GButton(
              icon: Icons.circle_outlined,
              text: 'status',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 100);
}
