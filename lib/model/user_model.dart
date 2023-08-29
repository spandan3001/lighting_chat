import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? imageUrl;

  const UserModel({
    required this.id,
    this.imageUrl,
    required this.name,
    required this.email,
  });

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      name: data["name"],
      email: data["email"],
      imageUrl: data['imageUrl'],
    );
  }
  static Map<String, Object> toMap(UserModel userModel) {
    return {
      "name": userModel.name,
      "email": userModel.email,
      "imageUrl": userModel.imageUrl ?? "",
    };
  }
}
