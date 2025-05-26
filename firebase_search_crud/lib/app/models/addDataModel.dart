import 'package:cloud_firestore/cloud_firestore.dart';

class AddDataModel {
  String? name;
  String? surName;
  String? id;

  AddDataModel({this.name, this.id, this.surName});

  AddDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    surName = json['surName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['surName'] = this.surName;
    return data;
  }
}
