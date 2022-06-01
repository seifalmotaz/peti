import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petiapp/pages/post/create/controller/post.dart';
import 'package:petiapp/pages/post/create/functions/get_color.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController
    with StateMixin<VideoPlayerController> {
  PostCreateController post = Get.find<PostCreateController>();
  final ImagePicker _picker = ImagePicker();

  Rx<Color?> color = Rx<Color?>(null);
  Rx<File?> file = Rx<File?>(null);
  Rx<File?> thumbinal = Rx<File?>(null);

  RxBool isPlaying = false.obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    await pickVideo();
    vinit();
  }

  Future pickVideo() async {
    // change(null, status: RxStatus.loading());
    final XFile? image = await _picker.pickVideo(
        source: ImageSource.gallery, maxDuration: const Duration(minutes: 3));
    if (image != null) {
      file.value = File(image.path);
    } else {
      Get.back();
    }
  }

  Future vinit() async {
    VideoPlayerController v = VideoPlayerController.file(file.value!);
    v.setLooping(true);
    await v.initialize();
    change(v, status: RxStatus.success());
    File vthumb = await VideoCompress.getFileThumbnail(
      file.value!.path,
      quality: 51,
    );
    thumbinal.value = vthumb;
    var c = await getColor(FileImage(vthumb));
    color.value = c;
  }

  @override
  void onClose() {
    state!.dispose();
    super.onClose();
  }
}
