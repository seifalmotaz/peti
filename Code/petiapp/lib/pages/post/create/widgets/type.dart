import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../create_image.dart';
import '../create_video.dart';

class ChooseFileType extends StatelessWidget {
  const ChooseFileType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      margin: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Ionicons.videocam_outline),
            title: Text('Video'.tr),
            onTap: () {
              Get.back();
              Get.to(() => const PostCreateVideo());
            },
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Ionicons.image_outline),
            title: Text('Photo'.tr),
            onTap: () {
              Get.back();
              Get.to(() => const PostCreateImage());
            },
          ),
        ],
      ),
    );
  }
}
