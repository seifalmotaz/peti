import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/models/pet.dart';
import 'package:petiapp/pages/post/create/widgets/type.dart';
import 'package:petiapp/providers/pet.dart';

class PostCreateController extends GetxController with StateMixin<List<Pet>> {
  // Calling func
  static PostCreateController get to => Get.find();

  PetProvider api = PetProvider();

  // publisher pet
  Rx<Pet?> pet = Rx<Pet?>(null);

  TextEditingController caption = TextEditingController();

  RxBool posting = false.obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    await getPets();
  }

  chooseType() async => await Get.bottomSheet(const ChooseFileType());

  getPets() async {
    Response res = await api.owned();
    if (res.statusCode == 200) {
      List<Pet> pets = [];
      for (var item in res.data) {
        pets.add(Pet.fromMap(item));
      }
      change(
        pets,
        status: pets.isEmpty ? RxStatus.empty() : RxStatus.success(),
      );
    }
  }
}
