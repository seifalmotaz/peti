import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:ionicons/ionicons.dart';
import 'package:petiapp/models/post.dart';
import 'package:petiapp/pages/pet/read/controller.dart';
import 'package:petiapp/pages/post/reader/reader.dart';
import 'package:petiapp/providers/post.dart';

class PostItemWidget extends StatelessWidget {
  final String tag;
  final Post post;
  const PostItemWidget(this.post, this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReadPetController controller = Get.find<ReadPetController>(tag: tag);
    return GestureDetector(
      onTap: () => Get.to(
        () => PostReader(
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
              Get.back();
              controller.deletePost(post.id!);
              return true;
            }
            return false;
          },
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: .5,
              color: Colors.grey,
            ),
          ),
          child: Stack(
            children: [
              if (post.file!.isVideo)
                SizedBox.expand(
                  child: CachedNetworkImage(
                    imageUrl: post.file!.thumbinal!,
                    imageBuilder: (context, imageProvider) {
                      return Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                )
              else
                SizedBox.expand(
                  child: CachedNetworkImage(
                    imageUrl: post.file!.url,
                    imageBuilder: (context, imageProvider) {
                      return Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.3, 1.0],
                    tileMode: TileMode.clamp,
                    colors: [
                      Colors.transparent,
                      Colors.black54,
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 11,
                bottom: 5,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Ionicons.heart,
                        color: Colors.white70,
                        size: 13,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        post.likes!.toString(),
                        style: const TextStyle(
                          fontFamily: 'roboton',
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(width: 7),
                      const Icon(
                        Icons.comment_sharp,
                        color: Colors.white70,
                        size: 13,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        post.comments!.toString(),
                        style: const TextStyle(
                          fontFamily: 'roboton',
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
