import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/functions/change_lang.dart';
import 'package:petiapp/pages/auth/wrapper/wrapper.dart';
import 'package:petiapp/pages/user/Settings/controller.dart';

class MoreSettingsWidget extends GetWidget<SettingsController> {
  const MoreSettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<SettingsController>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Icon(
                Icons.more_outlined,
                color: ThemeColors.primaryDark.withOpacity(.81),
              ),
              const SizedBox(width: 5),
              Text(
                'More'.tr,
                style: TextStyle(
                  color: ThemeColors.primaryDark,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () => Get.bottomSheet(changeLang()),
          title: Text(
            'Change Language'.tr,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
            size: 15,
          ),
        ),
        ListTile(
          onTap: () async {
            await GetStorage().erase();
            Get.offAll(() => const AuthWrapperPage());
          },
          title: Text(
            'LogOut'.tr,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.red[300],
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.red[300],
            size: 15,
          ),
        ),
      ],
    );
  }
}
