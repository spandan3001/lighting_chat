import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/firebase_services/firestore_services.dart';
import 'package:flash_chat/global_data.dart';
import 'package:flash_chat/screen_decider/screen_decider.dart';
import 'package:flash_chat/user_provider.dart';
import 'package:flash_chat/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/button_widget.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email, password;
  final _auth = FirebaseAuth.instance;
  late TextEditingController _userIdController, _passwordController;
  bool showPassword = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    _userIdController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(height: 48.0),
            TextField(
              controller: _userIdController,
              keyboardType: TextInputType.emailAddress,
              decoration: kTextInputDecoration(
                  hintText: 'Enter your Email', lableText: 'email'),
              onTap: () {
                setState(() {
                  errorMessage = "";
                });
              },
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              obscureText: !showPassword,
              decoration: kTextInputDecoration(
                lableText: 'Password',
                hintText: 'Enter your password',
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on password visible state choose the icon
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    showPassword = !showPassword;
                    setState(() {});
                  },
                ),
              ),
              onTap: () {
                setState(() {
                  errorMessage = "";
                });
              },
            ),
            if (errorMessage.isEmpty) const SizedBox(height: 30.0),
            if (errorMessage.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ButtonWidget(
              text: 'Log In',
              onPressed: () async {
                try {
                  if (context.mounted) {
                    final snapshot = await CloudService.userCollection
                        .where('email', isEqualTo: _userIdController.text)
                        .get();
                    print(snapshot.docs.length);
                    UserModel userModel =
                        UserModel.fromSnapshot(snapshot.docs.first);
                    if (context.mounted) {
                      Provider.of<UserProvider>(context, listen: false)
                          .setUser(userModel);
                    }
                  }
                  if (context.mounted) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const Loading();
                      },
                    );
                  }
                  await _auth.signInWithEmailAndPassword(
                      email: _userIdController.text,
                      password: _passwordController.text);
                  if (context.mounted) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == "unknown") {
                    errorMessage = "Nothing is Entered";
                  } else if (e.code == "wrong-password") {
                    errorMessage = "Wrong password.Try Again";
                  } else if (e.code == "user-not-found") {
                    errorMessage = "User Not Found";
                  } else if (e.code == "too-many-requests") {
                    errorMessage = "Too-many-requests";
                  }
                  setState(() {});
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
