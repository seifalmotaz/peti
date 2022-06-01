import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/pages/post/create/controller/video.dart';
import 'package:petiapp/pages/post/create/widgets/actions_bar.dart';
import 'package:petiapp/providers/post.dart';
import 'package:video_player/video_player.dart';

import 'controller/post.dart';

class PostCreateVideo extends StatelessWidget {
  const PostCreateVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoController controller = Get.put(VideoController());
    return GestureDetector(
      onTap: () {
        controller.isPlaying.value = !controller.isPlaying.value;
        controller.state!.value.isPlaying
            ? controller.state!.pause()
            : controller.state!.play();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: controller.obx(
          (state) => Stack(
            children: [
              Obx(() => controller.thumbinal.value == null
                  ? const SizedBox()
                  : SizedBox.expand(
                      child: Opacity(
                        opacity: .3,
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: Image(
                            image: FileImage(
                                File(controller.thumbinal.value!.path)),
                            fit: BoxFit.cover,
                            colorBlendMode: BlendMode.overlay,
                          ),
                        ),
                      ),
                    )),
              if (state!.value.isInitialized)
                Center(
                  child: AspectRatio(
                    aspectRatio: state.value.aspectRatio,
                    child: VideoPlayer(state),
                  ),
                ),
              Obx(() => Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeInCubic,
                      switchOutCurve: Curves.easeInCubic,
                      child: controller.isPlaying.value
                          ? null
                          : const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 61,
                            ),
                    ),
                  )),
              ActionsBar(
                onTap: () async {
                  PostCreateController post = PostCreateController.to;
                  post.posting.value = true;
                  PostProvider postProvider = PostProvider();
                  await Future.delayed(const Duration(seconds: 1));
                  Response res = await postProvider.createVideo(
                    file: controller.file.value!.path,
                    thumbinal: controller.thumbinal.value!.path,
                    petId: post.pet.value!.id!,
                    color: controller.color.value!.toCssString(),
                    caption:
                        post.caption.text.isEmpty ? null : post.caption.text,
                  );
                  if (res.statusCode != 201) {
                    post.posting.value = false;
                  } else if (res.statusCode == 201) {
                    Get.back();
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
