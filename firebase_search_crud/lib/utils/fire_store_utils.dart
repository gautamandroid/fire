import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app/models/addDataModel.dart';
import '../app/models/userModel.dart';
import '../constant/collection_name.dart';
import '../constant/constant.dart';

class FireStoreUtils {

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;


  static getCurrentUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  static Future<bool> isLogin() async {
    bool isLogin = false;
    if (FirebaseAuth.instance.currentUser != null) {
      isLogin = await userExistOrNot(FirebaseAuth.instance.currentUser!.uid);
    } else {
      isLogin = false;
    }
    return isLogin;
  }

  static Future<bool> userExistOrNot(String uuid) async {
    bool isExit = false;
    await fireStore.collection(CollectionName.user).doc(uuid).get().then((value) {
      if (value.exists) {
        isExit = true;
      } else {
        isExit = false;
      }
    });
    return isExit;
  }

  static Future<bool> addUser(UserModel userModel) async {
    bool isUpdate = false;
    await fireStore
        .collection(CollectionName.user)
        .doc(userModel.id)
        .set(userModel.toJson())
        .whenComplete(() {
          isUpdate = true;
        })
        .catchError((error) {
          isUpdate = false;
          log('=======> add user ${error}');
        });
    return isUpdate;
  }

  static Future<bool> addDocument(AddDataModel dataModel) async {
    bool isUpdate = false;
    await fireStore
        .collection(CollectionName.data)
        .doc(dataModel.id)
        .set(dataModel.toJson())
        .whenComplete(() {
          isUpdate = true;
        })
        .catchError((error) {
          isUpdate = false;
          log('=======> add user ${error}');
        });
    return isUpdate;
  }

  static Future<bool> addUpdateDocument(AddDataModel dataModel) async {
    bool isUpdate = false;
    await fireStore
        .collection(CollectionName.data)
        .doc(dataModel.id)
        .update(dataModel.toJson())
        .whenComplete(() {
          isUpdate = true;
        })
        .catchError((error) {
          isUpdate = false;
          log('=======> update data ${error}');
        });
    return isUpdate;
  }

  static Future<bool> deleteDocument(String id) async {
    bool isUpdate = false;
    await fireStore
        .collection(CollectionName.data)
        .doc(id)
        .delete()
        .whenComplete(() {
      isUpdate = true;
    })
        .catchError((error) {
      isUpdate = false;
      log('=======> update data ${error}');
    });
    return isUpdate;
  }

  static Future<UserModel?> getUserProfile(String uuid) async {
    UserModel? userModel;

    await fireStore
        .collection(CollectionName.user)
        .doc(uuid)
        .get()
        .then((value) {
          if (value.exists) {
            Constant.userModel = UserModel.fromJson(value.data()!);
            userModel = UserModel.fromJson(value.data()!);
          }
        })
        .catchError((error) {
          log('===> get user profile ${error}');
          userModel = null;
        });
    return userModel;
  }

  static Future<List<AddDataModel>> getDataList() async {
    List<AddDataModel> addDataList = [];
    QuerySnapshot snap = await fireStore.collection(CollectionName.data).get();
    for (var data in snap.docs) {
      Map<String, dynamic>? addData = data.data() as Map<String, dynamic>?;
      if (addData != null) {
        addDataList.add(AddDataModel.fromJson(addData));
      } else {
        log('======> data is null get');
      }
    }
    return addDataList;
  }

  static Future<List<AddDataModel>> searchByName(String name) async {
    try {
      final snapshot = await fireStore
          .collection(CollectionName.data)
          .where('name', isGreaterThanOrEqualTo: name)
          .where('name', isLessThanOrEqualTo: name + '\uf8ff')
          .get();

      return snapshot.docs
          .map((doc) => AddDataModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log('Search error: $e');
      return [];
    }
  }


}
