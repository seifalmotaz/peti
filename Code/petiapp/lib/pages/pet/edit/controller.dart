import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/models/pet.dart';
import 'package:petiapp/pages/user/profile/profile.dart';
import 'package:petiapp/providers/pet.dart';
import 'package:petiapp/services/auth.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditPetController extends GetxController {
  final dynamic petId;
  Rx<Pet?> pet = Rx<Pet?>(null);
  EditPetController(this.petId);

  final PetProvider api = PetProvider();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController deleteBtnController =
      RoundedLoadingButtonController();

  TextEditingController name = TextEditingController();
  RxnString birthdayString = RxnString(null);
  TextEditingController birthday = TextEditingController();
  RxString gender = 'Male'.obs;
  TextEditingController type = TextEditingController();
  TextEditingController breed = TextEditingController();

  RxBool deleteIt = false.obs;

  getPetData() async {
    Response res = await api.read(petId);
    if (res.statusCode == 200) pet.value = Pet.fromMap(res.data);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    if (petId is String) {
      await getPetData();
    } else if (petId is Pet) {
      pet.value = petId;
    }
    name.text = pet.value!.name!;
    birthday.text = pet.value!.birthDate;
    type.text = pet.value!.type!;
    breed.text = pet.value!.breed ?? '';
    gender.value = pet.value!.gender!;
  }

  save() async {
    if (form.currentState!.validate()) {
      Response res = await api.update(
        pet.value!.id!,
        name: name.text,
        gender: gender.value,
        type: type.text,
        breed: breed.text.isEmpty ? null : breed.text,
        birthday: birthdayString.value,
      );
      if (res.statusCode == 200) {
        return Get.showSnackbar(GetBar(
          message: 'All saved.'.tr,
          duration: const Duration(seconds: 3),
        ));
      }
    }
  }

  delete() async {
    if (form.currentState!.validate()) {
      Response res = await api.delete(pet.value!.id!);
      if (res.statusCode == 200) {
        return Get.offAll(() => ProfilePage(AuthService.to.userData.id!));
      }
    }
  }
}
