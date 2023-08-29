import 'package:flutter/material.dart';

import '../constants.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});
  static const id = 'contact_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CONTACTS"),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
