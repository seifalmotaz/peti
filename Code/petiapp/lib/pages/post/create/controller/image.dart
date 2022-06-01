import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petiapp/pages/post/create/controller/post.dart';
import 'package:petiapp/pages/post/create/functions/get_color.dart';

class ImageController extends GetxController with StateMixin<File> {
  PostCreateController post = Get.find<PostCreateController>();
  final ImagePicker _picker = ImagePicker();

  Rx<Color?> color = Rx<Color?>(null);

  @override
  Future<void> onReady() async {
    super.onReady();
    await pickPhoto();
    await loadColor();
  }

  Future pickPhoto() async {
    change(null, status: RxStatus.loading());
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 51);
    if (image != null) {
      File file = File(image.path);
      change(file, status: RxStatus.success());
    } else {
      Get.back();
    }
  }

  Future loadColor() async {
    var c = await getColor(FileImage(File(state!.path)));
    color.value = c;
  }
}
