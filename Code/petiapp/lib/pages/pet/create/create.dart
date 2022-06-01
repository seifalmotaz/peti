import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/user/settings/setting.dart';
import 'package:petiapp/services/auth.dart';

import 'controller.dart';
import 'widgets/first_form.dart';
import 'widgets/second_form.dart';
import 'widgets/third_form.dart';

class PetCreatePage extends GetView<PetCreateController> {
  const PetCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<PetCreateController>(PetCreateController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: ThemeColors.primaryDark,
          onPressed: () {
            if (controller.pageController.page == 0) {
              Get.back();
            } else {
              if (controller.pageController.page == 3) {
                controller.lastForm.value = false;
              }
              controller.pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            }
          },
        ),
        title: Text(
          'Add Pet',
          style: TextStyle(
            color: ThemeColors.primaryDark,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Obx(
            () => AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: controller.lastForm.value
                  ? TextButton(
                      child: controller.obx(
                        (state) => Text('Save'.tr),
                        onLoading: Text('Loading'.tr),
                      ),
                      onPressed: controller.status == RxStatus.loading()
                          ? null
                          : () async => await controller.saveData(),
                    )
                  : TextButton(
                      child: Text('Next'.tr),
                      onPressed: () async {
                        late bool isValid;
                        if (controller.pageController.page == 0) {
                          isValid = controller.formOne.currentState!.validate();
                        } else if (controller.pageController.page == 1) {
                          isValid = controller.formTwo.currentState!.validate();
                        } else if (controller.avatar.value == null) {
                          isValid = false;
                          Get.showSnackbar(GetBar(
                            message: 'Choose avatar'.tr,
                            duration: const Duration(seconds: 3),
                          ));
                        } else {
                          isValid = true;
                        }
                        if (isValid) {
                          await controller.pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                          if (controller.pageController.page == 3) {
                            controller.lastForm.value = true;
                          }
                        }
                      },
                    ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const FirstFormWidget(),
            const SecondFormWidget(),
            const ThirdFormWidget(),
            Obx(
              () => Container(
                margin: const EdgeInsets.all(13),
                child: SwitchListTile.adaptive(
                  value: controller.wantM.value,
                  activeColor: ThemeColors.secondPrimaryMuted,
                  inactiveThumbColor: ThemeColors.primaryDarkMuted,
                  onChanged: (v) {
                    if (v && AuthService.to.user.value!.isAccountCompleted) {
                      controller.wantM.value = v;
                    } else if (!v) {
                      controller.wantM.value = v;
                    } else {
                      Get.showSnackbar(
                        GetBar(
                          duration: const Duration(seconds: 5),
                          message:
                              "You can't make it until you complete your profile"
                                  .tr,
                          mainButton: TextButton(
                            onPressed: () => Get.to(() => const SettingsPage()),
                            child: const Text('Go'),
                          ),
                        ),
                      );
                    }
                  },
                  title: Text(
                    'Allow other users to request that your pet marry their pet.'
                        .tr,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
