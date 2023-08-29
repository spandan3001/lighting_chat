import 'package:flash_chat/firebase_services/firestore_services.dart';
import 'package:flash_chat/screens/home_screen.dart';
import 'package:flash_chat/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/user_model.dart';
import '../screens/welcome_screen.dart';
import '../user_provider.dart';

class ScreenDecider extends StatefulWidget {
  const ScreenDecider({Key? key}) : super(key: key);
  static const id = '/';

  @override
  State<ScreenDecider> createState() => _ScreenDeciderState();
}

class _ScreenDeciderState extends State<ScreenDecider> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show a dialog to confirm whether the user wants to exit
        bool exitConfirmation = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Exit'),
              content: const Text('Do you really want to exit?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );

        return exitConfirmation;
      },
      child: StreamBuilder(
        stream: CloudService.auth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final email = CloudService.auth.currentUser?.email;
            return FutureBuilder(
              future: CloudService.userCollection
                  .where('email', isEqualTo: email)
                  .get(),
              builder: (context, userSnap) {
                if (userSnap.hasData) {
                  UserModel userModel =
                      UserModel.fromSnapshot(userSnap.data!.docs.first);
                  if (context.mounted) {
                    Provider.of<UserProvider>(context, listen: false)
                        .setUser(userModel);
                  }
                  return const HomeScreen();
                } else {
                  return const Loading();
                }
              },
            );
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
