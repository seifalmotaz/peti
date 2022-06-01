import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/widgets/custom_field.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'controller.dart';
import 'pages/choose_city.dart';
import 'pages/choose_country.dart';

class EditLocationPage extends GetView<EditLocationController> {
  const EditLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(EditLocationController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Your home location'.tr,
            style: TextStyle(
              color: ThemeColors.primaryDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          leading: BackButton(color: ThemeColors.primaryDark),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTextField(
                readOnly: true,
                controller: controller.country,
                labelText: 'Country'.tr,
                hintText: 'Country you live in'.tr,
                onTap: () async {
                  Map? item = await Get.to(() => const ChooseCountry());
                  if (item != null) {
                    controller.countryMap.value = item;
                    controller.country.text = (item['name'] as String).tr;
                  }
                },
              ),
              const SizedBox(height: 13),
              CustomTextField(
                readOnly: true,
                controller: controller.city,
                labelText: 'City'.tr,
                hintText: 'City'.tr,
                onTap: () async {
                  if (controller.countryMap.value != null) {
                    String? item = await Get.to(
                        () => ChooseCity(controller.countryMap.value!['iso']));
                    if (item != null) {
                      controller.countryMap.value!['city'] = item;
                      controller.city.text = item.tr;
                    }
                  } else {
                    Get.showSnackbar(GetBar(message: 'Choose country first.'));
                  }
                },
              ),
              const SizedBox(height: 13),
              CustomTextField(
                controller: controller.region,
                labelText: 'Region'.tr,
                hintText: 'Region'.tr,
              ),
              const SizedBox(height: 13),
              // Obx(() => AnimatedSwitcher(
              //       duration: Duration(milliseconds: 213),
              //       child: controller.locationLoading.value
              //           ? Center(
              //               child: SpinKitPulse(color: Colors.grey),
              //             )
              //           : Column(
              //               children: [
              //                 Text(
              //                   'Let other users see how far your pets are from them.'
              //                       .tr,
              //                   style: TextStyle(color: Colors.grey[600]),
              //                 ),
              //                 Row(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Flexible(
              //                       child: RichText(
              //                         text: TextSpan(
              //                           children: [
              //                             TextSpan(
              //                               text: '\n ' + "Notice:".tr + ' ',
              //                               style: TextStyle(
              //                                 color: ThemeColors
              //                                     .firstPrimaryMuted
              //                                     .withOpacity(.81),
              //                                 fontSize: 13,
              //                               ),
              //                             ),
              //                             TextSpan(
              //                               text:
              //                                   'If you want to enable this please turn on the location services for a minute when you are in home with your pets.'
              //                                       .tr,
              //                               style: TextStyle(
              //                                 color: Colors.grey,
              //                                 fontSize: 11,
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                     Switch.adaptive(
              //                       value: controller.locationPositioned.value,
              //                       activeColor: ThemeColors.secondPrimary,
              //                       inactiveThumbColor: ThemeColors.primaryDark,
              //                       onChanged: (value) {
              //                         if (!controller.locationPositioned.value)
              //                           controller.getLocation();
              //                         else
              //                           controller.locationPositioned.value =
              //                               false;
              //                       },
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //     )),
              // SizedBox(height: 13),
              SizedBox(
                width: Get.width * .27,
                child: RoundedLoadingButton(
                  color: ThemeColors.firstPrimary.withOpacity(.81),
                  height: kToolbarHeight * .81,
                  width: Get.width * .3,
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
                    bool save = await controller.save();
                    controller.btnController.stop();
                    if (save) Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
