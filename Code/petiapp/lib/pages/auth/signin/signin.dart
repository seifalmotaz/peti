import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/auth/controller.dart';
import 'package:petiapp/pages/auth/widgets/field.dart';
import 'package:petiapp/pages/auth/widgets/header.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormController controller = Get.find<FormController>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: ThemeColors.primaryDark,
        body: Stack(
          children: [
            SizedBox.expand(
              child: Opacity(
                opacity: .45,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: const Image(
                    image: AssetImage('assets/backgrounds/cat.jpg'),
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.overlay,
                  ),
                ),
              ),
            ),
            Form(
              key: controller.form,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Header('SignIn'.tr),
                      const SizedBox(height: 27),
                      AuthField(
                        fieldControler: controller.email,
                        hint: 'Email'.tr,
                        icon: FeatherIcons.mail,
                        inputType: TextInputType.emailAddress,
                        width: Get.width * .8,
                        validator: (string) {
                          if (string != null && string.isNotEmpty) {
                            Pattern pattern =
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                r"{0,253}[a-zA-Z0-9])?)*$";
                            RegExp regex = RegExp(pattern.toString());
                            if (!regex.hasMatch(string)) {
                              return 'Email is invalid'.tr;
                            } else {
                              return null;
                            }
                          }
                          return 'Must type an email'.tr;
                        },
                      ),
                      const SizedBox(height: 21),
                      AuthField(
                        fieldControler: controller.password,
                        hint: 'Password'.tr,
                        icon: FeatherIcons.lock,
                        obscureText: true,
                        width: Get.width * .8,
                        validator: (string) {
                          if (string != null && string.isNotEmpty) {
                            if (string.length >= 8) {
                              return null;
                            } else {
                              return 'Password must be mor then 8 characters'
                                  .tr;
                            }
                          } else {
                            return 'Must type password'.tr;
                          }
                        },
                      ),
                      const SizedBox(height: 27),
                      RoundedLoadingButton(
                        elevation: 0,
                        controller: controller.btnController,
                        color: ThemeColors.firstPrimary.withOpacity(.65),
                        child: Text(
                          'SignIn'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: kToolbarHeight * .3,
                          ),
                        ),
                        onPressed: () => controller.signin(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
