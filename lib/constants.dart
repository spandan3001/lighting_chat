import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF1EBEA5);
const kSecondaryColor = Color(0xFF25D366);
const kCardColor = Color(0xFFdcf8c6);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

InputDecoration kMessageTextFieldDecoration =
    const InputDecoration(hintText: 'Message', border: InputBorder.none);

InputDecoration kTextInputDecoration(
    {String lableText = "", String hintText = "", Widget? suffixIcon}) {
  return InputDecoration(
    labelText: lableText,
    hintText: hintText,
    fillColor: Colors.white,
    filled: true,
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.grey)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.grey.shade400)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.red, width: 2.0)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.red, width: 2.0)),
  );
}
