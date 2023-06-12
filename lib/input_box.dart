import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InputMessage extends StatelessWidget {
  InputMessage({Key? key, this.controller, required this.onPressed, this.onChanged})
      : super(key: key);

  final controller;
  final VoidCallback onPressed;
  final Function(String)? onChanged;

  final User? loggedInUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kMessageContainerDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged!,
              decoration: kMessageTextFieldDecoration,
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              'Send',
              style: kSendButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
