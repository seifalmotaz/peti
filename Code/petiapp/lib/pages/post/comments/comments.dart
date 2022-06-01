import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/models/comment.dart';

import 'controller.dart';

class CommentsListPage extends GetView<CommentsListController> {
  final String postId;
  const CommentsListPage(this.postId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CommentsListController(postId));
    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
        controller.isWriting.value = false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: .81,
          backgroundColor: Colors.white,
          leading: BackButton(
            color: ThemeColors.primaryDark,
          ),
          title: Text(
            'Comments'.tr,
            style: TextStyle(
              color: ThemeColors.primaryDark,
              fontFamily: 'CRFont',
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                color: ThemeColors.firstPrimaryMuted,
                backgroundColor: Colors.white,
                edgeOffset: 9,
                onRefresh: () =>
                    Future.sync(() => controller.pagingController.refresh()),
                child: PagedListView<int, Comment>(
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Comment>(
                    firstPageProgressIndicatorBuilder: (_) => Center(
                      child: SpinKitRing(
                        color: ThemeColors.primaryDarkMuted,
                        lineWidth: 3,
                      ),
                    ),
                    itemBuilder: (context, item, index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 13),
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: item.commenter.avatar!,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          imageBuilder: (context, imageProvider) {
                            return CircleAvatar(backgroundImage: imageProvider);
                          },
                        ),
                        title: Text(
                          item.commenter.username,
                          style: const TextStyle(
                            fontFamily: 'CourgetteFont',
                          ),
                        ),
                        subtitle: Text(
                          item.content,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontFamily: 'roboton',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: controller.isWriting.value
                      ? Container(
                          constraints: const BoxConstraints(
                            minHeight: kToolbarHeight,
                            maxHeight: kToolbarHeight * 3,
                            minWidth: double.infinity,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 11),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                color: Colors.black12,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(
                                child: TextFormField(
                                  cursorColor: ThemeColors.secondPrimaryMuted,
                                  autofocus: true,
                                  controller: controller.fieldControler,
                                  onEditingComplete: () => controller.saveIt(),
                                  textInputAction: TextInputAction.send,
                                  style: TextStyle(
                                      color: ThemeColors.primaryDark
                                          .withOpacity(.61)),
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: 'Add a comment...',
                                    hintStyle: TextStyle(
                                        color: ThemeColors.primaryDark
                                            .withOpacity(.51)),
                                    contentPadding: const EdgeInsets.all(11),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => controller.saveIt(),
                                icon: Icon(
                                  Icons.send,
                                  size: 27,
                                  color: ThemeColors.firstPrimaryMuted,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Material(
                          color: Colors.white70,
                          child: InkWell(
                            splashColor: Colors.white.withOpacity(.13),
                            highlightColor:
                                Colors.grey.shade100.withOpacity(.081),
                            onTap: () => controller.isWriting.value = true,
                            child: Container(
                              height: 45,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white70,
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.black12,
                                    width: .3,
                                  ),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Add a comment...',
                                  style: TextStyle(
                                    fontFamily: 'roboton',
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
