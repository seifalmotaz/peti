import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/models/pet.dart';
import 'package:petiapp/models/user.dart';
import 'package:petiapp/providers/pet.dart';
import 'package:petiapp/providers/user.dart';

class ProfileController extends GetxController {
  Rx<User?> user = Rx<User?>(null);
  User? get userData => user.value;
  RxList<Pet> pets = <Pet>[].obs;

  // class vars and funcs
  final String userId;
  ProfileController(this.userId);

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    UserProvider userConnect = UserProvider();
    PetProvider petConnect = PetProvider();
    Response res = await userConnect.read(userId);
    if (res.statusCode == 200) user.value = User.fromMap(res.data);
    Response res2 = await petConnect.owned(userId: userId);
    if (res2.statusCode == 200) {
      pets.value = [];
      for (var item in res2.data) {
        pets.add(Pet.fromMap(item));
      }
    }
  }
}
