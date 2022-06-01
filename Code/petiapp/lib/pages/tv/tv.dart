import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/pages/tv/widgets/empty.dart';
import 'package:petiapp/pages/tv/widgets/list.dart';

import 'controller.dart';

class WatchTv extends StatelessWidget {
  const WatchTv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WatchTvController controller = Get.put(WatchTvController());
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: controller.obx(
          (state) => const PostsListWidget(),
          onEmpty: const TvOnEmpty(),
        ),
      ),
    );
  }
}
