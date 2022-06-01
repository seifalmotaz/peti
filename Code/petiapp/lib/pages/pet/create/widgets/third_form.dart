import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/pet/create/controller.dart';

class ThirdFormWidget extends GetView<PetCreateController> {
  const ThirdFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<PetCreateController>();
    return Obx(
      () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 51,
                );
                if (image != null) controller.avatar.value = File(image.path);
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: Get.width * .61,
                width: Get.width * .61,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: controller.avatar.value != null
                    ? Image.file(
                        controller.avatar.value!,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.white,
                          size: Get.width * .17,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 13),
            Text(
              '@' + controller.name.text,
              style: TextStyle(
                color: ThemeColors.primaryDark,
                fontWeight: FontWeight.w600,
                fontSize: 23,
                fontFamily: 'CRFont',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
