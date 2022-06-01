import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/pages/post/create/controller/post.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:petiapp/providers/post.dart';
import 'controller/image.dart';
import 'widgets/actions_bar.dart';

class PostCreateImage extends StatelessWidget {
  const PostCreateImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageController controller = Get.put(ImageController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: controller.obx(
        (file) => Obx(
          () => Container(
            color: controller.color.value,
            child: Stack(
              children: [
                SizedBox.expand(
                  child: Opacity(
                    opacity: .3,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Image(
                        image: FileImage(File(file!.path)),
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.overlay,
                      ),
                    ),
                  ),
                ),
                SizedBox.expand(
                  child: Image(
                    image: FileImage(File(file.path)),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                ActionsBar(
                  onTap: () async {
                    PostCreateController post = PostCreateController.to;
                    post.posting.value = true;
                    PostProvider postProvider = PostProvider();
                    await Future.delayed(const Duration(seconds: 1));
                    Response res = await postProvider.createImage(
                      file: file.path,
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
      ),
    );
  }
}
