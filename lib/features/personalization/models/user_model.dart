import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yt_ecommerce_admin_panel/utils/formatters/formatter.dart';

import '../../../utils/constants/enums.dart';

class UserModel {
  final String? id;
  String fullName;
  String username;
  String email;
  String phoneNumber;
  String profilePicture;
  AppRole role;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    this.id,
    this.fullName = '',
    required this.email,
    this.phoneNumber = '',
    this.profilePicture = '',
    this.username = '',
    this.role = AppRole.user,
    this.updatedAt,
    this.createdAt,
  });

  static UserModel empty() => UserModel(
        email: '',
      );

  ///Helper methods
  String get formattedDate => TFormatter.formatDate(createdAt);

  String get formattedUpdatedAtDate => TFormatter.formatDate(updatedAt);

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  ///Convert model to JSon structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'FullName': fullName,
      'Email': email,
      'Username': username,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Role': role.name.toString(),
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now(),
    };
  }

  ///Factory method to create UserModel from Firebase document Snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data() != null){
      final data = document.data()!;
      return UserModel(
        id: document.id,
        fullName: data.containsKey('FullName') ? data['FullName'] ?? '' : '',
        email: data.containsKey('Email') ? data['Email'] ?? '' : '',
        username: data.containsKey('Username') ? data['Username'] ?? '' : '',
        phoneNumber:
        data.containsKey('PhoneNumber') ? data['PhoneNumber'] ?? '' : '',
        profilePicture: data.containsKey('ProfilePicture')
            ? data['ProfilePicture'] ?? ''
            : '',
        role: data.containsKey('Role')
            ? (data['Role'] ?? AppRole.user) == AppRole.admin.name.toString()
            ? AppRole.admin
            : AppRole.user
            : AppRole.user,
        createdAt: data.containsKey('CreatedAt')
            ? data['CreatedAt']?.toDate() ?? DateTime.now()
            : DateTime.now(),
        updatedAt: data.containsKey('UpdatedAt')
            ? data['UpdatedAt']?.toDate() ?? DateTime.now()
            : DateTime.now(),
      );
    }else{
      return UserModel.empty();
    }
  }
}
