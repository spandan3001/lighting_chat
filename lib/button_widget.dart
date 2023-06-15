import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({Key? key, this.color, this.text, required this.onPressed})
      : super(key: key);

  final Color? color;
  final String? text;
  final VoidCallback onPressed;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color,
      borderRadius: BorderRadius.circular(30.0),
      elevation: 5.0,
      child: MaterialButton(
        onPressed: widget.onPressed,
        minWidth: 200.0,
        height: 42.0,
        child: Text(widget.text ?? "NO DATA",
            style: const TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }
}
