import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/pet/edit/edit_pet.dart';
import 'package:petiapp/pages/pet/read/controller.dart';
import 'package:petiapp/pages/request/inbox/inbox.dart';
import 'package:petiapp/pages/user/profile/profile.dart';
import 'package:petiapp/services/auth.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String thetag;
  AppBarWidget(this.thetag, {Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size(Get.width, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    ReadPetController controller = Get.find<ReadPetController>(tag: thetag);
    return AppBar(
      centerTitle: true,
      elevation: .61,
      leading: BackButton(color: ThemeColors.primaryDarkMuted),
      title: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(controller.pet.value!.owner!.id!),
          ),
        ),
        child: Text(
          controller.pet.value != null
              ? controller.pet.value!.owner!.username
              : 'Unknown',
          style: TextStyle(
              fontFamily: 'CourgetteFont', color: ThemeColors.primaryDarkMuted),
        ),
      ),
      actions: [
        if (AuthService.to.userData.id == controller.pet.value!.owner!.id)
          IconButton(
            tooltip: "Settings",
            onPressed: () => Get.to(() => EditPetPage(controller.pet.value!)),
            icon: Icon(
              Icons.settings,
              color: controller.pet.value!.wantMarraige!
                  ? ThemeColors.secondPrimaryMuted
                  : ThemeColors.primaryDarkMuted,
            ),
          ),
        if (AuthService.to.userData.id == controller.pet.value!.owner!.id)
          GestureDetector(
            onTap: () =>
                Get.to(() => RequestsInboxPage(controller.pet.value!.id)),
            child: Container(
              height: double.infinity,
              margin: const EdgeInsets.all(11),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.notifications_none_outlined,
                      color: ThemeColors.primaryDarkMuted,
                    ),
                  ),
                  if (controller.requestsCount.value! > 0)
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ThemeColors.firstPrimaryMuted,
                        ),
                        child: Text(
                          controller.requestsCount.value.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
