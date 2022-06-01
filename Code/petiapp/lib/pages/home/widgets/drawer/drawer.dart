import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:petiapp/pages/post/create/petting.dart';
import 'package:petiapp/pages/request/inbox/inbox.dart';
import 'package:petiapp/pages/tv/tv.dart';
import 'package:petiapp/pages/user/Profile/profile.dart';
import 'package:petiapp/services/auth.dart';

import 'widgets/button.dart';

class MainDrawer extends StatelessWidget {
  final Function? onHome;
  final Function? onWatchVideos;
  const MainDrawer({
    Key? key,
    this.onHome,
    this.onWatchVideos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 13),
      margin: const EdgeInsets.all(13),
      width: 61,
      height: Get.height * .61,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(27),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerButton(
                icon: Ionicons.home_outline,
                onTap: () => onHome != null ? onHome!() : Get.back(),
              ),
              DrawerButton(
                icon: Icons.live_tv_outlined,
                onTap: () => onWatchVideos != null
                    ? onWatchVideos!()
                    : Get.to(() => const WatchTv()),
              ),
              DrawerButton(
                icon: Ionicons.file_tray_outline,
                onTap: () => Get.to(() => const RequestsInboxPage(null)),
              ),
              DrawerButton(
                icon: Ionicons.person_outline,
                onTap: () =>
                    Get.to(() => ProfilePage(AuthService.to.userData.id!)),
              ),
            ],
          ),
          DrawerButton(
            icon: Ionicons.add,
            onTap: () => Get.to(() => const PostCreatePetting()),
          ),
        ],
      ),
    );
  }
}
