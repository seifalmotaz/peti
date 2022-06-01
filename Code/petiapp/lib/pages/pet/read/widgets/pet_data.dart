import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/functions/local_date.dart';
import 'package:petiapp/pages/pet/read/controller.dart';
import 'package:petiapp/pages/request/Create/functions/new.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PetDataWidget extends StatelessWidget {
  final String thetag;
  const PetDataWidget(this.thetag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReadPetController controller = Get.find<ReadPetController>(tag: thetag);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(.5),
            width: .3,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: controller.pet.value!.avatar!,
            imageBuilder: (context, imageProvider) {
              return Center(
                child: Container(
                  height: 81,
                  width: 81,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 11),
          Text(
            '@${controller.pet.value!.name}',
            style: const TextStyle(
              fontFamily: 'CRFont',
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 11),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              controller.headerNumData(
                NumberFormat.compact().format(controller.pet.value!.followers!),
                'Fans',
              ),
              controller.headerNumData(
                controller.pet.value == null
                    ? '0'
                    : NumberFormat.compact()
                        .format(controller.pet.value!.likes),
                'Posts',
              ),
              controller.headerNumData(
                getLocalDate(controller.pet.value!.owner!.lastLogin!),
                'Last Active',
              ),
            ],
          ),
          const SizedBox(height: 11),
          ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: SizedBox(
              width: Get.width * .65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (!controller.isOwner.value)
                    Obx(() => Flexible(
                          flex: 3,
                          child: RoundedLoadingButton(
                            borderRadius: 0,
                            elevation: 0,
                            height: kToolbarHeight * .71,
                            color: controller.isFollowing.value
                                ? Colors.white
                                : ThemeColors.secondPrimaryMuted,
                            child: Text(
                              controller.isFollowing.value
                                  ? 'Unfollow'
                                  : 'Follow'.tr,
                              style: TextStyle(
                                color: controller.isFollowing.value
                                    ? ThemeColors.primaryDark
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: kToolbarHeight * .3,
                              ),
                            ),
                            controller: controller.btnController,
                            onPressed: () async {
                              controller.btnController.start();
                              Response res = await controller.petConnect
                                  .follow(controller.pet.value!.id!);
                              controller.btnController.stop();
                              if (res.statusCode == 200) {
                                controller.isFollowing.value = res.data;
                              }
                            },
                          ),
                        )),
                  if (!controller.isOwner.value &&
                      controller.pet.value!.wantMarraige!)
                    Flexible(
                      child: RoundedLoadingButton(
                        borderRadius: 0,
                        elevation: 0,
                        height: kToolbarHeight * .71,
                        color: ThemeColors.firstPrimaryMuted,
                        child: const Center(
                          child: Image(
                            height: kToolbarHeight * .45,
                            width: kToolbarHeight * .45,
                            image: AssetImage('assets/icons/bouquet.png'),
                          ),
                        ),
                        controller: controller.btnController2,
                        onPressed: () async {
                          controller.btnController2.start();
                          await newRequestDialog(controller.pet.value!);
                          controller.btnController2.stop();
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 11),
          if (controller.pet.value!.owner!.location != null)
            Text(
              'Location: ${controller.pet.value!.owner!.location!.region != null ? controller.pet.value!.owner!.location!.region! + ", " : ""}${controller.pet.value!.owner!.location!.city!}, ${controller.pet.value!.owner!.location!.country}',
              style: const TextStyle(
                fontFamily: 'roboton',
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
          Text(
            "${controller.pet.value!.birthText}, Breed: ${controller.pet.value!.breed ?? 'Unknown'}, Gender: ${controller.pet.value!.gender}",
            style: const TextStyle(
              fontFamily: 'roboton',
              color: Colors.grey,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
