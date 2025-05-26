import 'package:firebase_search_crud/app/modules/singup/view/singup_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constant/constant.dart';
import '../../../../theme/app_theme_data.dart';
import '../../../../widgets/global_widget.dart';
import '../../../../widgets/round_shape_button.dart';
import '../../../../widgets/text_field.dart';
import '../../../../widgets/text_view.dart';
import '../controller/login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return GetBuilder(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: TextView(text: 'Login'), backgroundColor: AppThemeData.blue),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    title: "User email".tr,
                    hintText: "User email".tr,
                    validator: (value) => Constant.validateEmail(value),
                    controller: controller.emailController.value,
                    onPress: () {},
                  ),
                  spaceH(),
                  Obx(
                    () => CustomTextFormField(
                      title: "Password".tr,
                      hintText: "Enter Password".tr,
                      validator: (value) => Constant.validatePassword(value),
                      controller: controller.passwordController.value,
                      obscureText: controller.isPasswordVisible.value,
                      suffix: GestureDetector(
                        onTap: () {
                          controller.isPasswordVisible.value = !controller.isPasswordVisible.value;
                        },
                        child: Icon(controller.isPasswordVisible.value ? Icons.visibility_off : Icons.visibility, color: AppThemeData.grey800),
                      ),
                      onPress: () {},
                    ),
                  ),
                  spaceH(),
                  RoundShapeButton(
                    title: "Log in".tr,
                    buttonColor: AppThemeData.primary300,
                    buttonTextColor: AppThemeData.grey50,
                    onTap: () {
                      final isValid = formKey.currentState?.validate() ?? false;
                      if (isValid) {
                        controller.emailSingIn();
                      }
                      // if (controller.emailController.value.text.trim().isEmpty) {
                      //   ShowToastDialog.toast("Please enter your username".tr);
                      // } else if (controller.passwordController.value.text.trim().isEmpty) {
                      //   ShowToastDialog.toast("Please enter your password".tr);
                      // } else {
                      //   // controller.userLogIn(emailId: controller.emailController.value.text, password: controller.passwordController.value.text, context: context);
                      // }
                    },
                    isLoading: controller.isLoading.value,
                    size: Size(358, 58),
                  ),
                  spaceH(height: 50),
                  GestureDetector(
                    onTap: () {
                      controller.loginWithGoogle();
                    },
                    child: TextView(text: 'Login with Google', fontSize: 16),
                  ),
                  Spacer(),

                  GestureDetector(
                    onTap: () {
                      Get.to(SingupView());
                    },
                    child: TextView(text: 'Sing Up', fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
