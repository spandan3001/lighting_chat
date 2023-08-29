import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/custom_cards/contact_card.dart';
import 'package:flash_chat/firebase_services/firestore_services.dart';
import 'package:flash_chat/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../model/user_model.dart';
import '../user_provider.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});
  static const id = 'contact_screen';

  @override
  Widget build(BuildContext context) {
    UserModel userModel =
        Provider.of<UserProvider>(context, listen: false).getUser();
    return Scaffold(
      appBar: AppBar(
        title: const Text("CONTACTS"),
        shadowColor: Colors.transparent,
        backgroundColor: kPrimaryColor,
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: CloudService.userCollection
              .where('email', isNotEqualTo: userModel.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<UserModel> userModels = snapshot.data!.docs
                  .map((e) => UserModel.fromSnapshot(e))
                  .toList();
              return ListView.builder(
                itemCount: userModels.length,
                itemBuilder: (context, index) {
                  return ContactCard(
                    userModel: userModel,
                    withUserModel: userModels[index],
                  );
                },
              );
            } else {
              return const Loading();
            }
          }),
    );
  }
}
