import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkapp/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    String name,
    String email,
    String phoneNumber,
    bool isOnline,
    String uid,
    String status,
    String profileUrl,
  }) : super(
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          isOnline: isOnline,
          uid: uid,
          status: status,
          profileUrl: profileUrl,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      name: snapshot['name'],
      email: snapshot['email'],
      phoneNumber: snapshot['phoneNumber'],
      uid: snapshot['uid'],
      isOnline: snapshot['isOnline'],
      profileUrl: snapshot['profileUrl'],
      status: snapshot['status'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "uid": uid,
      "isOnline": isOnline,
      "profileUrl": profileUrl,
      "status": status,
    };
  }
}
