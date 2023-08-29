import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPrimaryColor,
      borderRadius: BorderRadius.circular(30.0),
      elevation: 5.0,
      child: MaterialButton(
        onPressed: widget.onPressed,
        minWidth: 200.0,
        height: 42.0,
        child: Text(widget.text,
            style: const TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }
}
