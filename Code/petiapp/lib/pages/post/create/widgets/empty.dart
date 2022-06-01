import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/pet/create/create.dart';
import 'package:petiapp/pages/post/create/controller/post.dart';

class PettingOnEmpty extends StatelessWidget {
  const PettingOnEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await Get.find<PostCreateController>().getPets(),
      child: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.symmetric(vertical: 23),
        children: [
          const Text(
            "You don't have any pet profiles.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          TextButton(
            onPressed: () async {
              await Get.to(() => const PetCreatePage());
              await Get.find<PostCreateController>().getPets();
            },
            child: Text(
              'Add one...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: ThemeColors.firstPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
