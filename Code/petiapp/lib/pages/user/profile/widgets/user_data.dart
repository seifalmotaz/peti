import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/functions/local_date.dart';
import 'package:petiapp/pages/user/Profile/controller.dart';

class UserDataWidget extends GetWidget<ProfileController> {
  const UserDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<ProfileController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Stack(
            children: [
              Obx(() => CachedNetworkImage(
                    imageUrl: controller.userData!.avatar!,
                    imageBuilder: (context, imageProvider) {
                      return CircleAvatar(
                        radius: 81,
                        backgroundImage: imageProvider,
                      );
                    },
                  )),
              Positioned(
                bottom: 9,
                left: 7,
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Center(
                    child: Text(
                      getLocalDate(controller.userData!.lastLogin!),
                      style: TextStyle(color: ThemeColors.primaryDark),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            children: [
              Text(
                controller.userData!.username,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontFamily: 'CourgetteFont',
                  fontSize: 27,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: ThemeColors.secondPrimaryMuted,
                    size: 15,
                  ),
                  Text(
                    !controller.userData!.isLocation
                        ? 'Unknown'.tr
                        : '${controller.userData!.location!.region != null ? controller.userData!.location!.region!.tr + ", " : ""}${controller.userData!.location!.city!.tr}, ${controller.userData!.location!.country!.tr}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'roboton',
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
