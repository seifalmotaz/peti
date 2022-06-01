import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/models/pet.dart';
import 'package:petiapp/models/post.dart';
import 'package:petiapp/models/user.dart';
import 'package:petiapp/providers/pet.dart';
import 'package:petiapp/services/auth.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ReadPetController extends GetxController {
  final String petId;
  final PetProvider petConnect = PetProvider();
  ReadPetController(this.petId);

  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnController2 =
      RoundedLoadingButtonController();

  Rx<Pet?> pet = Rx<Pet?>(null);
  RxBool isOwner = false.obs;
  RxnInt requestsCount = RxnInt(null);
  RxBool isFollowing = false.obs;

  static const pageSize = 23;
  final PagingController<int, Post> pagingController =
      PagingController(firstPageKey: 0);

  getPetData() async {
    Response res = await petConnect.read(petId);
    if (res.statusCode == 200) {
      var user = User.fromMap(res.data['user']);
      pet.value = Pet.fromMap(res.data['pet'])..owner = user;
      isOwner.value = pet.value!.owner!.id! == AuthService.to.userData.id!;
      isFollowing.value = res.data['is_following'];
      requestsCount.value = res.data['requests_count'];
    }
  }

  getPosts(int pageKey) async {
    Response res = await petConnect.posts(petId, pageKey);
    if (res.statusCode == 200) {
      List<Post> posts = [];
      for (var item in res.data) {
        posts.add(Post.fromMap(item));
      }
      final isLastPage = posts.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(posts);
        update();
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(posts, nextPageKey);
        update();
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getPetData();
    pagingController.addPageRequestListener((pageKey) async {
      await getPosts(pageKey);
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

  likePost(String id, bool data) {
    Post post = pagingController.value.itemList!.firstWhere((e) => e.id == id);
    post.isLiked = data;
    update();
  }

  deletePost(String id) {
    pagingController.value.itemList!.removeWhere((e) => e.id == id);
    pagingController.refresh();
  }

  button({
    required Size size,
    required String title,
    required Color color,
    required GestureTapCallback onTap,
  }) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: size.width * .4,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'roboton',
            ),
          ),
        ),
      ),
    );
  }

  headerNumData(String num, String title) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: num,
            style: TextStyle(
              color: ThemeColors.primaryDark,
              fontFamily: 'roboton',
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          TextSpan(
            text: '\n$title',
            style: TextStyle(
              color: ThemeColors.primaryDark,
              fontFamily: 'roboton',
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
