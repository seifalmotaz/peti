import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/auth/controller.dart';
import 'package:petiapp/pages/auth/widgets/field.dart';
import 'package:petiapp/pages/auth/widgets/header.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormController controller = Get.find<FormController>();
    return Form(
      key: controller.form,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Header('SignUp'.tr),
              const SizedBox(height: 27),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthField(
                    fieldControler: controller.firstName,
                    hint: 'First name'.tr,
                    width: Get.width * .4,
                    validator: (string) {
                      if (string != null && string.isNotEmpty) {
                        int? i = int.tryParse(string);
                        if (i == null) {
                          return null;
                        }
                      }
                      return 'Invalid Username'.tr;
                    },
                  ),
                  AuthField(
                    fieldControler: controller.lastName,
                    hint: 'Last name'.tr,
                    width: Get.width * .4,
                    validator: (string) {
                      if (string != null && string.isNotEmpty) {
                        int? i = int.tryParse(string);
                        if (i == null) {
                          return null;
                        }
                      }
                      return 'Invalid Username'.tr;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 21),
              AuthField(
                fieldControler: controller.email,
                hint: 'Email'.tr,
                icon: FeatherIcons.mail,
                inputType: TextInputType.emailAddress,
                width: Get.width * .8,
                validator: (string) {
                  if (string != null && string.isNotEmpty) {
                    if (!string.isEmail) {
                      return 'Email is invalid'.tr;
                    } else {
                      return null;
                    }
                  } else {
                    return 'Must type an email'.tr;
                  }
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
                      return 'Password must be mor then 8 characters'.tr;
                    }
                  } else {
                    return 'Must type password'.tr;
                  }
                },
              ),
              const SizedBox(height: 21),
              AuthField(
                fieldControler: controller.rePassword,
                hint: 'Repassword'.tr,
                icon: FeatherIcons.lock,
                obscureText: true,
                width: Get.width * .8,
                validator: (string) {
                  if (controller.password.text == controller.rePassword.text) {
                    return null;
                  } else {
                    return "Password isn't matching".tr;
                  }
                },
              ),
              const SizedBox(height: 27),
              RoundedLoadingButton(
                elevation: 0,
                color: ThemeColors.firstPrimary.withOpacity(.65),
                child: Text(
                  'SignUp'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: kToolbarHeight * .3,
                  ),
                ),
                controller: controller.btnController,
                onPressed: () async {
                  if (controller.form.currentState!.validate()) {
                    bool checker = await controller.checkEmail();
                    if (!checker) {
                      controller.next();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
