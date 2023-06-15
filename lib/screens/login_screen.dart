import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/global_data.dart';
import 'package:flash_chat/screen_decider/screen_decider.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  late String email, password;
  final _auth = FirebaseAuth.instance;
  late TextEditingController _emailController, _passwordController;
  bool showPassword = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
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
              controller: _emailController,
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
                    // Based on passwordVisible state choose the icon
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
              color: Colors.lightBlueAccent,
              text: 'Log In',
              onPressed: () async {
                try {
                  NavigatorState state = Navigator.of(context);
                  await _auth.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text);
                  DocumentSnapshot<Map<String, dynamic>>? snap;
                  await FirebaseFirestore.instance
                      .collection('users')
                      .where('email', isEqualTo: _emailController.text)
                      .get()
                      .then((value) async {
                    for (var element in value.docs) {
                      print(element.id);
                      snap = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(element.id)
                          .get();
                    }
                  });
                  GlobalData.userName = snap?.data()!['userName'];
                  print(GlobalData.userName);
                  state.pushNamedAndRemoveUntil(
                      ScreenDecider.id, (route) => false);
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
