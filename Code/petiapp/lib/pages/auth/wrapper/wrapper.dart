import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/auth/controller.dart';
import 'package:petiapp/pages/auth/signup/widgets/city.dart';
import 'package:petiapp/pages/auth/signup/widgets/country.dart';
import 'package:petiapp/pages/auth/signup/widgets/phone.dart';
import 'package:petiapp/pages/auth/wrapper/widgets/navigator.dart';

class AuthWrapperPage extends StatelessWidget {
  const AuthWrapperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormController controller = Get.put(FormController());
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
            PageView(
              controller: controller.wrapperPageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const AuthNavigatorWidget(),
                const SignUpCountry(),
                Obx(() => SignUpCity(controller.location['iso'])),
                Obx(() => SignUpPhone(controller.location['dial_code'],
                    () => controller.updateProfile())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
