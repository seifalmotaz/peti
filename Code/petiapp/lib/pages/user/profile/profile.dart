import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/user/Profile/controller.dart';
import 'package:petiapp/pages/user/Profile/widgets/pets_list.dart';
import 'package:petiapp/pages/user/Profile/widgets/user_data.dart';
import 'package:petiapp/pages/user/Settings/setting.dart';
import 'package:petiapp/services/auth.dart';

class ProfilePage extends GetView<ProfileController> {
  final String userId;
  const ProfilePage(this.userId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<ProfileController>(ProfileController(userId));
    return Obx(
      () => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: controller.userData == null
            ? Scaffold(
                body: Center(
                  child: SpinKitRing(
                    color: ThemeColors.primaryDarkMuted,
                    lineWidth: 5,
                  ),
                ),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  leading: BackButton(color: ThemeColors.primaryDark),
                  title: Text(
                    controller.userData!.username,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontFamily: 'CRFont',
                    ),
                  ),
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.transparent,
                    systemNavigationBarIconBrightness: Brightness.dark,
                    systemNavigationBarColor: Colors.transparent,
                  ),
                  actions: [
                    if (AuthService.to.userData.id == controller.userId)
                      TextButton(
                        onPressed: () => Get.to(() => const SettingsPage()),
                        child: Text(
                          'Settings'.tr,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontFamily: 'CourgetteFont',
                          ),
                        ),
                      ),
                  ],
                ),
                body: RefreshIndicator(
                  onRefresh: () => controller.getData(),
                  child: ListView(
                    shrinkWrap: true,
                    children: const [
                      UserDataWidget(),
                      PetsListWidget(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
