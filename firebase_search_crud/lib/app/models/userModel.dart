import 'package:cloud_firestore/cloud_firestore.dart';


class UserModel {
  String? email;
  String? id;
  Timestamp? createdAt;
  bool? active;
  UserModel({this.email, this.id});


  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    active = json['active'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['id'] = this.id;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    return data;
  }
}