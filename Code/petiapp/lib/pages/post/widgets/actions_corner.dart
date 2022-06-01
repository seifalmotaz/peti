import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/models/post.dart';
import 'package:petiapp/pages/post/comments/comments.dart';
import 'package:petiapp/services/auth.dart';

class ActionsCorner extends StatelessWidget {
  final Post post;
  final Function delete;
  final Function like;
  final Function setData;
  final bool wantToDelete;
  final bool isLiked;
  const ActionsCorner({
    Key? key,
    required this.setData,
    required this.post,
    required this.like,
    required this.delete,
    required this.isLiked,
    required this.wantToDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      bottom: 0,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(21),
              ),
              child: Container(
                padding: const EdgeInsets.only(
                  right: 5,
                  left: 7,
                  top: 11,
                  bottom: 11,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(.17),
                      Colors.grey.withOpacity(.35),
                    ],
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade300.withOpacity(.25),
                        radius: 19,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.grey.withOpacity(.13),
                            borderRadius: BorderRadius.circular(100),
                            onTap: () async {
                              bool? data = await like();
                              if (data != null) {
                                setData(data, wantToDelete);
                              }
                            },
                            child: Center(
                              child: Icon(
                                isLiked
                                    ? Ionicons.heart
                                    : Ionicons.heart_outline,
                                color: isLiked
                                    ? ThemeColors.firstPrimaryMuted
                                    : Colors.white,
                                size: 19,
                                // size: 33,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade300.withOpacity(.25),
                        radius: 19,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.grey.withOpacity(.13),
                            borderRadius: BorderRadius.circular(100),
                            onTap: () =>
                                Get.to(() => CommentsListPage(post.id!)),
                            child: const Center(
                              child: Icon(
                                Icons.comment_sharp,
                                color: Colors.white,
                                size: 19,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (post.creator!.owner!.id == AuthService.to.userData.id)
                        const SizedBox(height: 15),
                      if (post.creator!.owner!.id == AuthService.to.userData.id)
                        CircleAvatar(
                          backgroundColor:
                              Colors.grey.shade300.withOpacity(.25),
                          radius: 17,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if (wantToDelete) {
                                  delete();
                                } else {
                                  Get.rawSnackbar(
                                      message: 'Tap again to delete it.');
                                  setData(isLiked, true);
                                }
                              },
                              splashColor: Colors.grey.withOpacity(.13),
                              borderRadius: BorderRadius.circular(100),
                              child: const Center(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 21,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
