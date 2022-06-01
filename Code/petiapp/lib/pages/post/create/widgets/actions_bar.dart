import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/post/create/controller/post.dart';

class ActionsBar extends StatelessWidget {
  final Function onTap;
  const ActionsBar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostCreateController post = PostCreateController.to;
    return Positioned(
      bottom: 13,
      left: 11,
      right: 11,
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Get.bottomSheet(
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 7,
                    ),
                    child: TextField(
                      controller: post.caption,
                      maxLines: null,
                      maxLength: 300,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'How is your pet today...?!'.tr,
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                height: kToolbarHeight * .81,
                decoration: BoxDecoration(
                  color: ThemeColors.secondPrimary.withOpacity(.21),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: ThemeColors.secondPrimary.withOpacity(.81),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Caption'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: kToolbarHeight * .3,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          Flexible(
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () => onTap(),
              child: Container(
                height: kToolbarHeight * .81,
                decoration: BoxDecoration(
                  color: ThemeColors.firstPrimary.withOpacity(.21),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: ThemeColors.firstPrimary.withOpacity(.81),
                  ),
                ),
                child: Obx(() => Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: post.posting.value
                            ? const SpinKitThreeBounce(
                                color: Colors.white,
                                size: kToolbarHeight * .3,
                              )
                            : Text(
                                'Post'.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: kToolbarHeight * .3,
                                ),
                              ),
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
