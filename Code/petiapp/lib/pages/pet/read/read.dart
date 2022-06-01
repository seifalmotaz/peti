import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/models/post.dart';
import 'package:petiapp/pages/pet/read/controller.dart';
import 'package:petiapp/pages/pet/read/widgets/pet_data.dart';
import 'package:petiapp/pages/pet/read/widgets/post_item.dart';

import 'widgets/app_bar.dart';

class ReadPetPage extends StatelessWidget {
  final String petId;
  const ReadPetPage(this.petId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReadPetController controller =
        Get.put(ReadPetController(petId), tag: petId);
    return Obx(() {
      if (controller.pet.value == null) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SpinKitRing(
              color: ThemeColors.primaryDarkMuted,
              lineWidth: 5,
              size: 27,
            ),
          ),
        );
      }
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(petId),
        body: RefreshIndicator(
          color: ThemeColors.firstPrimaryMuted,
          backgroundColor: Colors.white,
          edgeOffset: 9,
          onRefresh: () async {
            controller.pagingController.refresh();
            await controller.getPetData();
          },
          child: ListView(
            children: [
              PetDataWidget(petId),
              const SizedBox(height: 11),
              PagedGridView<int, Post>(
                shrinkWrap: true,
                pagingController: controller.pagingController,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(13),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 100 / 150,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                ),
                builderDelegate: PagedChildBuilderDelegate<Post>(
                  firstPageProgressIndicatorBuilder: (_) => Center(
                    child: SpinKitRing(
                      color: ThemeColors.primaryDarkMuted,
                      lineWidth: 3,
                    ),
                  ),
                  itemBuilder: (context, item, index) =>
                      PostItemWidget(item, petId),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
