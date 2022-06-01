import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/models/post.dart';
import 'package:petiapp/providers/post.dart';

class WatchTvController extends GetxController with StateMixin {
  PostProvider api = PostProvider();

  // api data
  RxInt key = 0.obs;
  RxList<Post> posts = RxList([]);

  @override
  Future<void> onReady() async {
    super.onReady();
    await watch();
  }

  refreshWatch() {
    key.value = 0;
    change(null, status: RxStatus.loading());
    watch();
  }

  watch() async {
    Response res = await api.watchTv(key.value);
    if (res.statusCode == 200) {
      for (var item in res.data) {
        posts.add(Post.fromMap(item));
      }
      if (posts.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        key.value = key.value++;
        change(null, status: RxStatus.success());
      }
    }
  }

  likePost(String id, bool data) {
    Post post = posts.firstWhere((e) => e.id == id);
    post.isLiked = data;
    update();
  }

  deletePost(String id) {
    posts.removeWhere((e) => e.id == id);
    if (posts.isEmpty) {
      change(null, status: RxStatus.empty());
    }
    update();
  }
}
