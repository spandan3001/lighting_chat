import 'package:flutter/material.dart';
import 'constants.dart';

class InputMessage extends StatefulWidget {
  const InputMessage(
      {Key? key, this.controller, required this.onPressed, this.onChanged})
      : super(key: key);

  final TextEditingController? controller;
  final VoidCallback onPressed;
  final Function(String)? onChanged;

  @override
  State<InputMessage> createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  @override
  Widget build(BuildContext context) {
    const baseWidth = 360;
    double w = MediaQuery.sizeOf(context).width;
    double fem = w / baseWidth;
    double fFem = fem * 0.97;
    const sendButtonWidth = 50.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: w - (fem * (sendButtonWidth + 10)),
            height: 50 * fem,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: kElevationToShadow[1]),
            child: Row(
              children: [
                InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {},
                  child: SizedBox(
                    width: fem * 40,
                    height: fem * 40,
                    child: const Icon(
                      Icons.emoji_emotions_outlined,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    style: TextStyle(fontSize: fFem * 18),
                    onChanged: widget.onChanged,
                    maxLines: null,
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {},
                  child: SizedBox(
                    width: fem * 40,
                    height: fem * 40,
                    child: const Icon(
                      Icons.attach_file_sharp,
                    ),
                  ),
                ),
                // InkWell(
                //   customBorder: const CircleBorder(),
                //   onTap: () {},
                //   child: SizedBox(
                //     width: fem * 40,
                //     height: fem * 40,
                //     child: const Icon(
                //       Icons.currency_rupee,
                //     ),
                //   ),
                // ),
                InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {},
                  child: SizedBox(
                    width: fem * 40,
                    height: fem * 40,
                    child: const Icon(
                      Icons.camera_alt,
                    ),
                  ),
                ),
                const SizedBox(width: 5)
              ],
            ),
          ),
          SizedBox(
            width: fem * sendButtonWidth,
            height: fem * 50,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: widget.onPressed,
              child: const Material(
                color: kPrimaryColor,
                elevation: 1,
                shape: CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.only(left: 3),
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
