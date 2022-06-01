import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/pet/edit/widgets/pet_data.dart';
import 'package:petiapp/pages/pet/pages/choose_type.dart';
import 'package:petiapp/pages/widgets/custom_field.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'controller.dart';

class EditPetPage extends GetView<EditPetController> {
  final dynamic petId;
  const EditPetPage(this.petId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(EditPetController(petId));
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: BackButton(color: ThemeColors.primaryDark),
              title: Text(
                'Pet Settings',
                style: TextStyle(
                  color: ThemeColors.primaryDark,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: .51,
              forceElevated: true,
              floating: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const PetDataWidget(),
                Form(
                  key: controller.form,
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Column(
                      children: [
                        Obx(
                          () => ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: SizedBox(
                              height: kToolbarHeight * .81,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: controller.gender.value == 'Male'
                                          ? Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              color: ThemeColors
                                                  .secondPrimaryMuted,
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
                                              onTap: () => controller
                                                  .gender.value = 'Male',
                                              child: SizedBox.expand(
                                                child: Center(
                                                  child: Text(
                                                    'Male'.tr,
                                                    style: TextStyle(
                                                      color: ThemeColors
                                                          .primaryDark,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  Flexible(
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: controller.gender.value == 'Female'
                                          ? Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              color:
                                                  ThemeColors.firstPrimaryMuted,
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
                                              onTap: () => controller
                                                  .gender.value = 'Female',
                                              child: SizedBox.expand(
                                                child: Center(
                                                  child: Text(
                                                    'Female'.tr,
                                                    style: TextStyle(
                                                      color: ThemeColors
                                                          .primaryDark,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                          controller: controller.name,
                          labelText: 'Name'.tr,
                          validator: (string) {
                            if (string!.split(' ').length > 1) {
                              return "You can't add spaces.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 13),
                        CustomTextField(
                          readOnly: true,
                          controller: controller.birthday,
                          labelText: 'Birthday'.tr,
                          textInputType: TextInputType.number,
                          onTap: () => DatePicker.showDatePicker(
                            context,
                            currentTime: DateTime.now(),
                            locale: LocaleType.en,
                            showTitleActions: true,
                            onConfirm: (date) {
                              controller.birthdayString.value = date
                                  .toUtc()
                                  .toIso8601String()
                                  .replaceFirst(RegExp('Z'), '');
                              controller.birthday.text = controller
                                  .birthdayString.value!
                                  .split('T')[0];
                            },
                          ),
                        ),
                        const SizedBox(height: 13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * .3,
                              child: CustomTextField(
                                readOnly: true,
                                controller: controller.type,
                                labelText: 'Type'.tr,
                                validator: (string) {
                                  if (string!.isNotEmpty) return null;
                                  return 'Choose type'.tr;
                                },
                                onTap: () async {
                                  String? selectedType =
                                      await Get.to(() => const ChooseType());
                                  if (selectedType != null) {
                                    controller.type.text = selectedType;
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: Get.width * .6,
                              child: CustomTextField(
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
                            ),
                          ],
                        ),
                        const SizedBox(height: 13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * .3,
                              height: kToolbarHeight * .81,
                              child: RoundedLoadingButton(
                                width: Get.width * .3,
                                height: kToolbarHeight * .81,
                                color:
                                    ThemeColors.firstPrimary.withOpacity(.81),
                                child: Text(
                                  'Save'.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: kToolbarHeight * .3,
                                  ),
                                ),
                                controller: controller.btnController,
                                onPressed: () async {
                                  controller.btnController.start();
                                  await controller.save();
                                  controller.btnController.stop();
                                },
                              ),
                            ),
                            SizedBox(
                              width: Get.width * .23,
                              height: kToolbarHeight * .73,
                              child: RoundedLoadingButton(
                                width: Get.width * .23,
                                height: kToolbarHeight * .73,
                                color: Colors.red.shade900.withOpacity(.81),
                                child: Text(
                                  'Delete'.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: kToolbarHeight * .3,
                                  ),
                                ),
                                controller: controller.deleteBtnController,
                                onPressed: () async {
                                  if (controller.deleteIt.value) {
                                    controller.deleteBtnController.start();
                                    await controller.delete();
                                    controller.deleteBtnController.stop();
                                  } else {
                                    controller.deleteIt.value = true;
                                    Get.rawSnackbar(
                                        message:
                                            'You want to delete it tap again');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
