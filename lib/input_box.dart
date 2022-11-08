import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InputMessage extends StatelessWidget {
  final controller;
  final Function onPressed;
  final Function onChanged;

  final User loggedInUser = FirebaseAuth.instance.currentUser;

  InputMessage({Key key, this.controller, this.onPressed, this.onChanged})
      : super(key: key);

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
              onChanged: onChanged,
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
