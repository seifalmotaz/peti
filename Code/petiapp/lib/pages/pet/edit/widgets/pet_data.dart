import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:image_picker/image_picker.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/pet/edit/controller.dart';

class PetDataWidget extends GetView<EditPetController> {
  const PetDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<EditPetController>();
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: .5,
            color: Colors.grey.shade200,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            offset: const Offset(0, -3),
            blurRadius: 7,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(
                source: ImageSource.gallery,
                imageQuality: 51,
              );
              if (image != null) {
                Response wait = await controller.api
                    .updateAvatar(controller.pet.value!.id!, image.path);
                if (wait.statusCode == 200) {
                  Get.rawSnackbar(message: 'All saved'.tr);
                }
              }
            },
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                CircleAvatar(
                  radius: 61,
                  backgroundImage:
                      CachedNetworkImageProvider(controller.pet.value!.avatar!),
                ),
                Positioned(
                  bottom: -13,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        color: ThemeColors.primaryDarkMuted,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 11),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 23),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@' + controller.pet.value!.name!,
                    style: const TextStyle(
                      fontSize: 23,
                      fontFamily: 'CRFont',
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Added since: ' +
                        controller.pet.value!.createdAt!.split('T')[0],
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Want Marraige: ',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                      Obx(() => Switch.adaptive(
                            value: controller.pet.value!.wantMarraige!,
                            activeColor: ThemeColors.secondPrimaryMuted,
                            inactiveThumbColor: ThemeColors.primaryDarkMuted,
                            onChanged: (value) async {
                              Response res = await controller.api.update(
                                controller.pet.value!.id!,
                                wantMarraige: value,
                              );
                              if (res.statusCode == 200) {
                                controller.pet.update((val) {
                                  val!.wantMarraige = value;
                                });
                              }
                            },
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
