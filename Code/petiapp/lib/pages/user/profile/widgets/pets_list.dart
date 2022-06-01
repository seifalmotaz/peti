import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/models/pet.dart';
import 'package:petiapp/pages/pet/create/create.dart';
import 'package:petiapp/pages/user/Profile/controller.dart';

class PetsListWidget extends GetWidget<ProfileController> {
  const PetsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<ProfileController>();
    return Column(
      children: [
        ListTile(
          horizontalTitleGap: 0,
          title: Text(
            'Owned Pets'.tr,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: IconButton(
            onPressed: () => Get.to(() => const PetCreatePage()),
            icon: const Icon(
              Icons.add,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: controller.pets.length,
              itemBuilder: (context, index) {
                Pet pet = controller.pets[index];
                return InkWell(
                  // onTap: () => Get.to(() => ReadPetPage(pet.id!)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: pet.avatar!,
                          imageBuilder: (context, imageProvider) {
                            return CircleAvatar(
                              radius: 30,
                              backgroundImage: imageProvider,
                            );
                          },
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '@' + pet.name!,
                          style: const TextStyle(
                            fontFamily: 'CRFont',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
