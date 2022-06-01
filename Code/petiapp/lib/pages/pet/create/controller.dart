import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/models/pet.dart';
import 'package:petiapp/providers/pet.dart';
import 'package:petiapp/services/auth.dart';

class PetCreateController extends GetxController with StateMixin {
  PageController pageController = PageController();

  TextEditingController name = TextEditingController();
  RxString birthdayString = ''.obs;
  TextEditingController birthday = TextEditingController();
  RxString gender = 'Male'.obs;
  TextEditingController type = TextEditingController();
  TextEditingController breed = TextEditingController();
  RxBool wantM = false.obs;

  GlobalKey<FormState> formOne = GlobalKey<FormState>();
  GlobalKey<FormState> formTwo = GlobalKey<FormState>();

  RxBool lastForm = false.obs;
  Rx<File?> avatar = Rx<File?>(null);

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    if (AuthService.to.user.value!.isAccountCompleted) wantM.value = true;
    super.onInit();
  }

  saveData() async {
    change(null, status: RxStatus.loading());
    if (Get.isSnackbarOpen != null && !Get.isSnackbarOpen!) {
      Pet pet = Pet(
        birthday: birthdayString.value,
        breed: breed.text.isEmpty ? null : breed.text,
        gender: gender.value,
        name: name.text,
        type: type.text,
        wantMarraige: wantM.value,
      );
      PetProvider api = PetProvider();
      Response res = await api.create(pet, avatar.value!);
      if (res.statusCode == 200) {
        Get.back();
      } else {
        change(null, status: RxStatus.success());
        Get.showSnackbar(GetBar(
          message: 'Something went wrong please try again later.'.tr,
          duration: const Duration(seconds: 3),
        ));
      }
    }
  }
}
