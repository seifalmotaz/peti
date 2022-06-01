import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:petiapp/models/comment.dart';
import 'package:petiapp/providers/comment.dart';

class CommentsListController extends GetxController {
  final String postId;
  CommentsListController(this.postId);

  CommentProvider commentConnect = CommentProvider();
  TextEditingController fieldControler = TextEditingController();

  static const pageSize = 23;
  RxBool isWriting = false.obs;
  final PagingController<int, Comment> pagingController =
      PagingController(firstPageKey: 0);

  getList(int pageKey) async {
    Response res = await commentConnect.list(postId, pageKey);
    if (res.statusCode == 200) {
      List<Comment> comments = [];
      for (var item in res.data) {
        comments.add(Comment.fromMap(item));
      }
      final isLastPage = comments.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(comments);
        update();
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(comments, nextPageKey);
        update();
      }
    }
  }

  saveIt() async {
    if (fieldControler.text.isEmail || fieldControler.text.split(' ').isEmpty) {
      return Get.showSnackbar(GetBar(
        message: 'Invalid text.'.tr,
      ));
    }
    Response res = await commentConnect.create(postId, fieldControler.text);
    if (res.statusCode == 200) {
      pagingController.itemList!.add(Comment.fromMap(res.data));
      Get.focusScope!.unfocus();
      isWriting.value = false;
      Future.sync(() => pagingController.refresh());
    }
  }

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) async {
      await getList(pageKey);
    });
    pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        Get.showSnackbar(GetBar(
          message: 'Something went wrong while fetching a new page.'.tr,
          mainButton: TextButton(
            onPressed: () => pagingController.retryLastFailedRequest(),
            child: const Text('Retry'),
          ),
        ));
      }
    });
  }
}
