import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InputMessage extends StatefulWidget {
  InputMessage(
      {Key? key, this.controller, required this.onPressed, this.onChanged})
      : super(key: key);

  final TextEditingController? controller;
  final VoidCallback onPressed;
  final Function(String)? onChanged;

  @override
  State<InputMessage> createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  final User? loggedInUser = FirebaseAuth.instance.currentUser;
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {},
                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.emoji_emotions_outlined,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      style: const TextStyle(fontSize: 18),
                      onChanged: widget.onChanged,
                      maxLines: null,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {},
                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.attach_file_sharp,
                      ),
                    ),
                  ),
                  InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {},
                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.currency_rupee,
                      ),
                    ),
                  ),
                  InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {},
                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.camera_alt,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5)
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 50,
            height: 50,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: widget.onPressed,
              child: const Material(
                color: kPrimaryColor,
                elevation: 1,
                shape: CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
