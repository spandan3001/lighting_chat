import 'package:flash_chat/screen_decider/screen_decider.dart';
import 'package:flash_chat/screens/contact_screen.dart';
import 'package:flash_chat/screens/home_screen.dart';
import 'package:flash_chat/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const FlashChat(),
    ),
  );
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: ScreenDecider.id,
      routes: {
        ScreenDecider.id: (context) => const ScreenDecider(),
        HomeScreen.id: (context) => const HomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ContactScreen.id: (context) => const ContactScreen(),
      },
    );
  }
}
