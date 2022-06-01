import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:petiapp/pages/home/controller.dart';
import 'package:petiapp/pages/home/widgets/list.dart';

import 'widgets/drawer/drawer.dart';
import 'widgets/empty.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      key: controller.scaffold,
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.sort, color: Colors.white),
          onPressed: () => controller.scaffold.currentState!.openDrawer(),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      drawer: MainDrawer(onHome: () => controller.refreshWatch()),
      body: controller.obx(
        (state) => const PostsListWidget(),
        onEmpty: const HomeOnEmpty(),
      ),
    );
  }
}
