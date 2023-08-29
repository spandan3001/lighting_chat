import 'package:flutter/cupertino.dart';

import 'firebase_services/firestore_services.dart';
import 'model/user_model.dart';

class UserProvider extends ChangeNotifier {
  late UserModel _userModel;

  UserModel getUser() {
    return _userModel;
  }

  Future<void> getUserFromDB() async {
    await CloudService.userCollection.doc(_userModel.id).get().then((value) {
      _userModel = UserModel.fromSnapshot(value);
    });
    _notifyAll();
  }

  Future<void> setUserToDB(UserModel userModel) async {
    await CloudService.userCollection.doc(_userModel.id).update(
          UserModel.toMap(userModel),
        );
    await getUserFromDB();
    _notifyAll();
  }

  Future<void> updateDB(Map<String, dynamic> data) async {
    await CloudService.userCollection.doc(_userModel.id).update(data);
    print(_userModel.id);
    await getUserFromDB();
    _notifyAll();
  }

  void setUser(UserModel userModel) {
    _userModel = userModel;
    _notifyAll();
  }

  String getEmail() {
    return _userModel.email;
  }

  void _notifyAll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
