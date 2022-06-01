import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/widgets/custom_field.dart';

import 'choosing_code.dart';
import 'controller.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(EditProfileController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(color: ThemeColors.primaryDark),
          elevation: 0,
          title: Text(
            'Edit profile',
            style: TextStyle(
              color: ThemeColors.primaryDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Form(
          key: controller.form,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: CustomTextField(
                        textInputType: TextInputType.name,
                        controller: controller.first,
                        labelText: 'First name'.tr,
                        validator: (string) {
                          if (string != null && string.isNotEmpty) {
                            int? i = int.tryParse(string);
                            if (i == null) {
                              return null;
                            }
                          }
                          return 'Invalid Username';
                        },
                      ),
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      flex: 2,
                      child: CustomTextField(
                        textInputType: TextInputType.name,
                        controller: controller.last,
                        labelText: 'Last name'.tr,
                        validator: (string) {
                          if (string != null && string.isNotEmpty) {
                            int? i = int.tryParse(string);
                            if (i == null) {
                              return null;
                            }
                          }
                          return 'Invalid Username';
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 17),
                CustomTextField(
                  textInputType: TextInputType.emailAddress,
                  controller: controller.email,
                  labelText: 'Email'.tr,
                  validator: (string) {
                    if (string != null && string.isNotEmpty) {
                      Pattern pattern =
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?)*$";
                      RegExp regex = RegExp(pattern.toString());
                      if (!regex.hasMatch(string)) {
                        return 'Email is invalid';
                      } else {
                        return null;
                      }
                    } else {
                      return 'Must type an email';
                    }
                  },
                ),
                const SizedBox(height: 17),
                Row(
                  children: [
                    Flexible(
                      child: CustomTextField(
                        controller: controller.countryCode,
                        readOnly: true,
                        labelBahave: false,
                        smallHint: false,
                        hintText: 'Code'.tr,
                        validator: (string) {
                          if (string!.isEmpty) {
                            return 'You must choose country code';
                          }
                        },
                        onTap: () async {
                          String? code = await choosingCode();
                          if (code != null) controller.countryCode.text = code;
                        },
                      ),
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      flex: 2,
                      child: CustomTextField(
                        textInputType: TextInputType.phone,
                        controller: controller.number,
                        labelText: 'Phone'.tr,
                        hintText: 'Prefer to put your whatsapp number'.tr,
                        validator: (string) {
                          if (string!.isNotEmpty) {
                            int? i = int.tryParse(string);
                            if (i == null) return 'Invalid Phone';

                            RegExp regex = RegExp(r"^[0-9]*$");
                            if (!regex.hasMatch(string)) return 'Invalid Phone';

                            if (string.length < 10 || string.length > 11) {
                              return 'Invalid Phone';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 17),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(23),
                    splashColor: ThemeColors.firstPrimary,
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      bool wait = await controller.save();
                      if (wait) {
                        Get.back();
                      } else {
                        Get.showSnackbar(GetBar(
                          duration: const Duration(seconds: 3),
                          message:
                              'Something went wrong please try again later.'.tr,
                        ));
                      }
                    },
                    child: Container(
                      height: kToolbarHeight * .81,
                      width: MediaQuery.of(context).size.width * .3,
                      decoration: BoxDecoration(
                        color: ThemeColors.firstPrimaryMuted.withOpacity(.81),
                        borderRadius: BorderRadius.circular(23),
                      ),
                      child: Center(
                        child: Text(
                          'Save'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
