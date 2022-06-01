import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/user/Settings/controller.dart';

import 'widgets/account.dart';
import 'widgets/more.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<SettingsController>(SettingsController());
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        children: [
          Text(
            'Settings'.tr,
            style: TextStyle(
              color: ThemeColors.primaryDark,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          const AcountSettingsWidget(),
          const SizedBox(height: 40),
          const MoreSettingsWidget(),
        ],
      ),
    );
  }
}
