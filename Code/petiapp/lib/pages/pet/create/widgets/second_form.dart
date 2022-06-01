import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/pet/create/controller.dart';
import 'package:petiapp/pages/pet/pages/choose_type.dart';
import 'package:petiapp/pages/widgets/custom_field.dart';

class SecondFormWidget extends GetWidget<PetCreateController> {
  const SecondFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<PetCreateController>();
    return Form(
      key: controller.formTwo,
      child: Container(
        margin: const EdgeInsets.all(13),
        child: Column(
          children: [
            Obx(
              () => ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: SizedBox(
                  height: kToolbarHeight * .81,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: controller.gender.value == 'Male'
                              ? Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: ThemeColors.secondPrimaryMuted,
                                  child: Center(
                                    child: Text(
                                      'Male'.tr,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () => controller.gender.value = 'Male',
                                  child: SizedBox.expand(
                                    child: Center(
                                      child: Text(
                                        'Male'.tr,
                                        style: TextStyle(
                                          color: ThemeColors.primaryDark,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      Flexible(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: controller.gender.value == 'Female'
                              ? Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: ThemeColors.firstPrimaryMuted,
                                  child: Center(
                                    child: Text(
                                      'Female'.tr,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () =>
                                      controller.gender.value = 'Female',
                                  child: SizedBox.expand(
                                    child: Center(
                                      child: Text(
                                        'Female'.tr,
                                        style: TextStyle(
                                          color: ThemeColors.primaryDark,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            CustomTextField(
              readOnly: true,
              controller: controller.type,
              labelText: 'Type'.tr,
              validator: (string) {
                if (string!.isNotEmpty) return null;
                return 'Choose type';
              },
              onTap: () async {
                String? selectedType = await Get.to(() => const ChooseType());
                if (selectedType != null) controller.type.text = selectedType;
              },
            ),
            const SizedBox(height: 13),
            CustomTextField(
              controller: controller.breed,
              labelText: 'Breed'.tr + ' ' + 'Optional'.tr,
              validator: (string) {
                if (string!.isNotEmpty) {
                  int? i = int.tryParse(string);
                  if (i == null) {
                    return null;
                  } else {
                    return 'Choose breed';
                  }
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
