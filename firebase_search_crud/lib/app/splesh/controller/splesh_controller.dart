import 'dart:async';
import 'dart:developer';
import 'package:firebase_search_crud/app/modules/home/view/home_view.dart';
import 'package:firebase_search_crud/app/modules/login/view/login_view.dart';
import 'package:firebase_search_crud/app/modules/singup/view/singup_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../constant/constant.dart';
import '../../../utils/fire_store_utils.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    Timer(Duration(seconds: 3), () {
      redirectScreen();
    });

    super.onInit();
  }

  redirectScreen() async {
    log('=========> call redirect screen');

    bool isLogin = await FireStoreUtils.isLogin();
    if (isLogin == true) {
      Constant.userModel = await FireStoreUtils.getUserProfile(FireStoreUtils.getCurrentUserId());
      Get.off(HomeView());
    } else {
      Get.to(LoginView());
    }
  }
}
