import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart' hide Response;
import 'package:getwidget/getwidget.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/auth/controller.dart';
import 'package:petiapp/pages/auth/signin/signin.dart';
import 'package:petiapp/pages/auth/signup/signup.dart';
import 'package:petiapp/pages/auth/widgets/header.dart';

class AuthNavigatorWidget extends StatelessWidget {
  const AuthNavigatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormController controller = Get.find<FormController>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Header('Welcome'.tr),
          const SizedBox(height: 27),
          InkWell(
            onTap: () async {
              controller.isSignUp.value = true;
              await Get.to(() => const SignUpPage());
              controller.isSignUp.value = false;
            },
            borderRadius: BorderRadius.circular(45),
            child: Container(
              height: kToolbarHeight,
              width: Get.width * .8,
              decoration: BoxDecoration(
                color: ThemeColors.secondPrimary.withOpacity(.21),
                borderRadius: BorderRadius.circular(45),
                border: Border.all(
                  color: ThemeColors.secondPrimary.withOpacity(.81),
                ),
              ),
              child: Center(
                child: Text(
                  'SignUp'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: kToolbarHeight * .3,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 17),
          InkWell(
            onTap: () => Get.to(() => const SignInPage()),
            borderRadius: BorderRadius.circular(45),
            child: Container(
              height: kToolbarHeight,
              width: Get.width * .8,
              decoration: BoxDecoration(
                color: ThemeColors.firstPrimary.withOpacity(.21),
                borderRadius: BorderRadius.circular(45),
                border: Border.all(
                  color: ThemeColors.firstPrimary.withOpacity(.81),
                ),
              ),
              child: Center(
                child: Text(
                  'SignIn'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: kToolbarHeight * .3,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 17),
          GFButton(
            shape: GFButtonShape.pills,
            elevation: 0,
            size: kToolbarHeight * .81,
            text: 'SignIn with Facebook',
            textStyle: const TextStyle(
              fontSize: kToolbarHeight * .31,
              fontWeight: FontWeight.bold,
            ),
            icon: const Icon(
              Icons.facebook,
              color: Colors.white,
              size: kToolbarHeight * .61,
            ),
            onPressed: () async {
              final LoginResult result =
                  await FacebookAuth.instance.login(permissions: [
                'public_profile',
                'email',
              ]);
              if (result.status == LoginStatus.success) {
                bool? res = await controller.facebook();
                if (res != null && res) {
                  controller.next();
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
