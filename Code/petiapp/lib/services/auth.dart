import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:petiapp/models/user.dart';

class AuthService extends GetxService {
  // Calling func
  static AuthService get to => Get.find();

  // vars
  RxBool isAuthenticated = false.obs;
  RxBool isUpdated = true.obs;
  Rx<User?> user = Rx<User?>(null);

  // mini funcs
  get token => user.value!.accessToken;
  User get userData => user.value!;

  // funcs
  saveData(User data) {
    isAuthenticated.value = true;
    user.value = data;
    GetStorage getStorge = GetStorage();
    getStorge.write('userAuth', data.toMap());
    user.value = data;
  }

  @override
  void onInit() {
    super.onInit();
    GetStorage getStorge = GetStorage();
    Map<String, dynamic>? userData = getStorge.read('userAuth');
    if (userData != null) {
      user = User.fromMap(userData).obs;
      isAuthenticated.value = true;
    }
  }
}
