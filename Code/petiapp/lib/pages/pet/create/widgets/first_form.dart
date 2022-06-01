import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:petiapp/pages/widgets/custom_field.dart';

import '../controller.dart';

class FirstFormWidget extends GetWidget<PetCreateController> {
  const FirstFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<PetCreateController>();
    return Form(
      key: controller.formOne,
      child: Container(
        margin: const EdgeInsets.all(13),
        child: Column(
          children: [
            CustomTextField(
              controller: controller.name,
              labelText: 'Name'.tr,
              validator: (string) {
                if (string == null || string.isEmpty || string.isEmail) {
                  return 'Invalid Name';
                }
                if (string.split(' ').length > 1) {
                  return "You can't add spaces.";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 13),
            CustomTextField(
              controller: controller.birthday,
              labelText: 'Birthday'.tr,
              readOnly: true,
              validator: (string) {
                if (string == null || string.isEmpty) return 'Invalid Birthday';
              },
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  currentTime: DateTime.now(),
                  locale: LocaleType.en,
                  showTitleActions: true,
                  onConfirm: (date) {
                    controller.birthdayString.value = date
                        .toUtc()
                        .toIso8601String()
                        .replaceFirst(RegExp('Z'), '');
                    controller.birthday.text =
                        controller.birthdayString.value.split('T')[0];
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
