import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/auth/controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUpPhone extends StatelessWidget {
  final String code;
  final Function func;
  const SignUpPhone(this.code, this.func, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormController controller = Get.find<FormController>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Phone Number'.tr,
            style: const TextStyle(
              fontSize: 33,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Prefers'.tr,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFFB4B4B4),
                  ),
                ),
                TextSpan(
                  text: ' Whatsapp'.tr,
                  style: TextStyle(
                    fontSize: 15,
                    color: const Color(0xFF25D366).withOpacity(.81),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 13),
          Container(
            width: Get.width * .8,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              color: Colors.grey.shade100.withOpacity(.13),
              borderRadius: BorderRadius.circular(21),
            ),
            child: TextField(
              controller: controller.phone,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(
                color: Colors.grey[600],
                fontFamily: 'Pattaya',
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 16),
                prefixIcon: Icon(
                  Icons.perm_phone_msg_rounded,
                  color: Color(0xFFB4B4B4),
                ),
                hintText: 'Phone Number',
                hintStyle: TextStyle(
                  color: Color(0xFFB4B4B4),
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(height: 7),
          SizedBox(
            width: Get.width * .7,
            child: Text(
              'Preferably put your number.\nThis is an optional step. You can put the WhatsApp number safely.\nOnly those who you agree to their requests to meet the two pets can see your number.'
                  .tr,
              style: TextStyle(
                fontSize: 11,
                color: const Color(0xFFB4B4B4).withOpacity(.81),
              ),
            ),
          ),
          const SizedBox(height: 17),
          SizedBox(
            width: Get.width * .8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => controller.previous(),
                  child: Text(
                    'Back'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RoundedLoadingButton(
                  width: Get.width * .5,
                  height: kToolbarHeight * .71,
                  elevation: 0,
                  color: ThemeColors.firstPrimary.withOpacity(.65),
                  disabledColor: ThemeColors.firstPrimary.withOpacity(.21),
                  child: Text(
                    'Save All'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: kToolbarHeight * .27,
                    ),
                  ),
                  controller: controller.btnController,
                  onPressed: () => func(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
