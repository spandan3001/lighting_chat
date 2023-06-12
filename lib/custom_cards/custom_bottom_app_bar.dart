import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
        child: GNav(
          tabBackgroundColor: Colors.black12,
          color: Colors.grey,
          gap: 10,
          backgroundColor: Colors.white,
          padding: EdgeInsets.all(10),
          activeColor: Color(0xFF25D366),
          tabs: const [
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
