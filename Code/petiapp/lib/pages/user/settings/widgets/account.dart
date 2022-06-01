import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/user/Settings/controller.dart';
import 'package:petiapp/pages/user/edit/edit_user.dart';
import 'package:petiapp/pages/user/edit_location/edit_location.dart';

class AcountSettingsWidget extends GetWidget<SettingsController> {
  const AcountSettingsWidget({Key? key}) : super(key: key);

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
                Icons.person_outline,
                color: ThemeColors.primaryDark.withOpacity(.81),
              ),
              const SizedBox(width: 5),
              Text(
                'Account'.tr,
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
          onTap: () async {
            ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(
              source: ImageSource.gallery,
              imageQuality: 51,
            );
            if (image != null) controller.uploadAvatar(image.path);
          },
          title: Text(
            'Change profile picture'.tr,
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
        Obx(
          () => ListTile(
            onTap: () => Get.to(() => const EditProfilePage()),
            horizontalTitleGap: 0,
            leading: controller.user.value!.isPhone
                ? null
                : Icon(
                    FeatherIcons.alertCircle,
                    color: ThemeColors.firstPrimaryMuted,
                  ),
            title: Text(
              'Edit profile'.tr,
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
        ),
        Obx(
          () => ListTile(
            onTap: () => Get.to(() => const EditLocationPage()),
            horizontalTitleGap: 0,
            leading: controller.user.value!.isLocation
                ? null
                : Icon(
                    FeatherIcons.alertCircle,
                    color: ThemeColors.firstPrimaryMuted,
                  ),
            title: Text(
              'Edit home location'.tr,
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
        ),
      ],
    );
  }
}
