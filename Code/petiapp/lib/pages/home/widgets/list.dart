import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/models/post.dart';
import 'package:petiapp/pages/home/controller.dart';
import 'package:petiapp/pages/post/image/widget.dart';
import 'package:petiapp/providers/post.dart';

class PostsListWidget extends StatelessWidget {
  const PostsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find<HomeController>();
    return Obx(() => Container(
          height: Get.height,
          width: Get.width,
          color: Colors.black,
          child: RefreshIndicator(
            onRefresh: () async => await controller.refreshWatch(),
            child: PageView.builder(
              itemCount: controller.posts.length,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              onPageChanged: (value) {
                if (value == (controller.posts.length - 5)) {
                  controller.watch();
                }
              },
              itemBuilder: (context, index) {
                Post post = controller.posts[index];
                return PostImageWidget(
                  post,
                  like: () async {
                    PostProvider api = PostProvider();
                    Response res = await api.like(post.id!);
                    if (res.statusCode == 200) {
                      controller.likePost(post.id!, res.data);
                      return res.data;
                    }
                    return null;
                  },
                  delete: () async {
                    PostProvider api = PostProvider();
                    Response res = await api.delete(post.id!);
                    if (res.statusCode == 200) {
                      controller.deletePost(post.id!);
                      return true;
                    }
                    return false;
                  },
                );
              },
            ),
          ),
        ));
  }
}
