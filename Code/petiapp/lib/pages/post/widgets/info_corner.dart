import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petiapp/functions/local_date.dart';
import 'package:petiapp/models/post.dart';
import 'package:petiapp/pages/pet/read/read.dart';

class InfoCorner extends StatelessWidget {
  final Post post;
  const InfoCorner(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.to(() => ReadPetPage(post.creator!.id!)),
          child: Container(
            padding: const EdgeInsets.all(11),
            child: Column(
              children: [
                if (post.content != null)
                  Text(
                    post.content,
                    style: const TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.black38,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CRFont',
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: post.creator!.avatar!,
                          placeholder: (_, __) => const Center(
                            child: SpinKitRing(
                              color: Colors.white,
                              lineWidth: 3,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          imageBuilder: (c, i) => CircleAvatar(
                            radius: 25,
                            backgroundImage: i,
                          ),
                        ),
                        const SizedBox(width: 7),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '@' + post.creator!.name!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'CRFont',
                              ),
                            ),
                            const SizedBox(height: 3),
                            RichText(
                              text: TextSpan(
                                children: [
                                  if (post.location!.region != null)
                                    TextSpan(
                                      text: post.location!.region,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 10,
                                      ),
                                    ),
                                  if (post.location!.region != null)
                                    const TextSpan(
                                      text: ', ',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 10,
                                      ),
                                    ),
                                  if (post.location!.city != null)
                                    TextSpan(
                                      text: post.location!.city!.tr,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 10,
                                      ),
                                    ),
                                  if (post.location!.city != null &&
                                      post.location!.country != null)
                                    const TextSpan(
                                      text: ', ',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 10,
                                      ),
                                    ),
                                  if (post.location!.country != null)
                                    TextSpan(
                                      text: post.location!.country!.tr,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 10,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          getLocalDate(post.createdAt!),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Likes'.tr + ' ' + post.likes!.toString(),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Comments'.tr + ' ' + post.comments!.toString(),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
