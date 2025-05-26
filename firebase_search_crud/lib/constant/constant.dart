import 'package:firebase_search_crud/app/models/userModel.dart';
import 'package:uuid/uuid.dart';


class Constant {
  static const userPlaceHolder = "assets/images/user_place_holder.png";
  static const placeLogo = "assets/images/place_holder.png";

  static UserModel? userModel;
  static bool isLogin = false;

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return "Minimum password length should be 6";
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }


   static String getUuid(){
     return Uuid().v4();
   }

}
