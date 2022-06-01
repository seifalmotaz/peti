import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:petiapp/pages/pet/create/create.dart';
import 'package:petiapp/pages/user/settings/setting.dart';
import 'package:petiapp/services/auth.dart';

import 'controller/post.dart';
import 'widgets/empty.dart';
import 'widgets/pets.dart';

class PostCreatePetting extends StatelessWidget {
  const PostCreatePetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostCreateController controller = Get.put(PostCreateController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: .21,
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: const Text(
          'Posted by',
          style: TextStyle(color: Colors.black, fontFamily: 'CRFont'),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (AuthService.to.userData.isLocation) {
                await Get.to(() => const PetCreatePage());
                await controller.getPets();
              } else {
                Get.showSnackbar(
                  GetBar(
                    duration: const Duration(seconds: 5),
                    message: "You should put your country and city".tr,
                    mainButton: TextButton(
                      onPressed: () => Get.to(() => const SettingsPage()),
                      child: const Text('Go'),
                    ),
                  ),
                );
              }
            },
            icon: const Icon(
              Ionicons.add_outline,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: controller.obx(
        (state) => PetsList(state!),
        onEmpty: const PettingOnEmpty(),
      ),
    );
  }
}
