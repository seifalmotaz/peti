import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/models/user.dart';
import 'package:petiapp/providers/user.dart';
import 'package:petiapp/services/auth.dart';

class SettingsController extends GetxController {
  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    user.value = AuthService.to.userData;
    super.onInit();
  }

  uploadAvatar(photo) async {
    UserProvider userConnect = UserProvider();
    Response res = await userConnect.updateAvatar(photo);
    if (res.statusCode == 200) {
      AuthService.to.saveData(User.fromMap(res.data));
      Get.showSnackbar(GetBar(message: 'All saved.'.tr));
    } else {
      Get.showSnackbar(
        GetBar(
          message: 'Something went wrong please try again later.'.tr,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
