import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_search_crud/app/modules/home/view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../constant/constant.dart';
import '../../../../utils/fire_store_utils.dart';
import '../../../../widgets/show_toast_dialogue.dart';
import '../../../models/userModel.dart';

class LoginController extends GetxController {
  RxBool isPasswordVisible = true.obs;
  RxBool isLoading = false.obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
  }

  emailSingIn() async {
    String email = emailController.value.text;
    String passWord = passwordController.value.text;

    try {
      singInWithEmailAndPassword(email, passWord).then((value) async {
        await FireStoreUtils.getUserProfile(FireStoreUtils.getCurrentUserId()).then((value) async {
          if (value != null) {
            if (value.active == true) {
              Constant.isLogin = await FireStoreUtils.isLogin();
              // Get.offAllNamed(Routes.LOGIN);
              Get.offAll(HomeView());
            } else {
              FirebaseAuth.instance.signOut();
              ShowToastDialog.toast('Please Contact Administer');
            }
          } else {
            ShowToastDialog.toast('Email and Password is Invalid');
          }
        });
      });
    } catch (e) {
      log('====> error of login $e');
      ShowToastDialog.toast('Email & Password invalid');
    }
  }

  Future<UserCredential?> singInWithEmailAndPassword(email, passWord) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: passWord).catchError((error) {
      log('======>Error ${error}');
    });
  }

  loginWithGoogle() async {
     isLoading.value = true;
    await signInWithGoogle().then((value) async {
      isLoading.value = false;
      if (value != null) {
        if (value.additionalUserInfo!.isNewUser) {
          UserModel userModel = UserModel();
          userModel.id = value.user!.uid;
          userModel.email = value.user!.email;
          userModel.createdAt = Timestamp.now();
          userModel.active = true;
          await FireStoreUtils.addUser(userModel).then((value) {
            if (value == true) {
              isLoading.value = false;
              Get.offAll(() => HomeView());
            }
          });
        } else {
          FireStoreUtils.userExistOrNot(value.user!.uid).then((userExit) async {
            if (userExit == true) {
              UserModel? userModel = await FireStoreUtils.getUserProfile(value.user!.uid);
              if (userModel != null) {
                 Get.offAll(HomeView());
              } else {
                await FirebaseAuth.instance.signOut();
              }
            } else {
              UserModel userModel = UserModel();
              userModel.id = value.user!.uid;
              userModel.email = value.user!.email;
            }
          });
        }
      }
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn().catchError((error) {
        ShowToastDialog.toast("something_went_wrong".tr);
        log('====> error of google login  $error');
        return null;
      });

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log('====> error of google login catch   $e');
      debugPrint(e.toString());
    }
    return null;
  }
}
