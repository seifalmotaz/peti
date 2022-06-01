import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/models/location.dart';
import 'package:petiapp/models/user.dart';
import 'package:petiapp/pages/Home/home.dart';
import 'package:petiapp/providers/user.dart';
import 'package:petiapp/services/auth.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class FormController extends GetxController {
  RxBool isSignUp = false.obs;
  PageController pagecontroller = PageController();
  PageController wrapperPageController = PageController();

  GlobalKey<FormState> form = GlobalKey();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  RxMap location = {}.obs;

  next() => (isSignUp.value ? pagecontroller : wrapperPageController).nextPage(
      duration: const Duration(milliseconds: 500), curve: Curves.easeIn);

  previous() =>
      (isSignUp.value ? pagecontroller : wrapperPageController).previousPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);

  Future checkEmail() async {
    btnController.start();
    UserProvider userProvider = UserProvider();
    Response res = await userProvider.isExist(email.text);
    if (res.statusCode == 406) {
      Get.snackbar(
        'Not Acceptable (406)'.tr,
        'The ${res.data["detail"]} is already exist.'.tr,
        isDismissible: true,
        backgroundColor: Colors.white54,
      );
      btnController.stop();
      return true;
    }
    btnController.stop();
    return false;
  }

  Future signin() async {
    btnController.start();
    UserProvider userProvider = UserProvider();
    if (form.currentState!.validate()) {
      Response res = await userProvider.signin(email.text, password.text);
      if (res.statusCode == 200) {
        try {
          AuthService.to.saveData(User.fromMap(res.data));
          Get.offAll(() => const HomePage());
        } catch (e) {
          Get.snackbar(
            'Saving data error'.tr,
            'There is error when saving login data, Please try again later.'.tr,
            isDismissible: true,
            backgroundColor: Colors.white54,
          );
        }
      }
    }
    btnController.stop();
  }

  updateProfile() async {
    UserProvider userProvider = UserProvider();
    Response res = await userProvider.updateLocation(
      iso: location['iso'],
      city: location['city'],
      country: location['country'],
    );
    if (res.statusCode == 200) {
      AuthService.to.userData.location = Location.fromMap(res.data);
      AuthService.to.saveData(AuthService.to.userData);
      if (phone.text.isNotEmpty) {
        Response res2 = await userProvider.updateAccount(
          phone: location['dial_code'] + ' ' + int.parse(phone.text).toString(),
        );
        if (res2.statusCode == 200) {
          AuthService.to.saveData(User.fromMap(res2.data));
        }
      }
      Get.offAll(() => const HomePage());
    }
  }

  Future facebook() async {
    Map data = await FacebookAuth.instance.getUserData();
    AccessToken? token = await FacebookAuth.instance.accessToken;
    UserProvider userProvider = UserProvider();
    if (token != null) {
      Response res = await userProvider.facebook(
        clientId: token.userId,
        email: data['email'],
        accessToken: token.token,
        avatar: data['picture']['data']['url'],
        username: data['name'],
      );
      if (res.statusCode == 200) {
        try {
          AuthService.to.saveData(User.fromMap(res.data));
          Get.offAll(() => const HomePage());
        } catch (e) {
          Get.snackbar(
            'Saving data error'.tr,
            'There is error when saving login data, Please try again later.'.tr,
            isDismissible: true,
            backgroundColor: Colors.white54,
          );
        }
      } else if (res.statusCode == 201) {
        try {
          AuthService.to.saveData(User.fromMap(res.data));
        } catch (e) {
          Get.snackbar(
            'Saving data error'.tr,
            'There is error when saving login data, Please try again later.'.tr,
            isDismissible: true,
            backgroundColor: Colors.white54,
          );
        }
        return true;
      } else if (res.statusCode == 406) {
        Get.snackbar(
          'Not Acceptable (406)'.tr,
          'The ${res.data["detail"]} is already exist.'.tr,
          isDismissible: true,
          backgroundColor: Colors.white54,
        );
      } else {
        Get.snackbar(
          'Server error (500)'.tr,
          'There is server error please try again later.'.tr,
          isDismissible: true,
          backgroundColor: Colors.white54,
        );
      }
    }
  }

  Future signup() async {
    btnController.start();
    UserProvider userProvider = UserProvider();
    Response res = await userProvider.signup(
      firstName: firstName.text,
      lastName: lastName.text,
      email: email.text,
      pass: password.text,
      location: location,
      phone: phone.text.isEmpty
          ? null
          : location['dial_code'] + ' ' + int.parse(phone.text).toString(),
    );
    if (res.statusCode == 200) {
      try {
        AuthService.to.saveData(User.fromMap(res.data));
        Get.offAll(() => const HomePage());
      } catch (e) {
        Get.snackbar(
          'Saving data error'.tr,
          'There is error when saving login data, Please try again later.'.tr,
          isDismissible: true,
          backgroundColor: Colors.white54,
        );
      }
    } else if (res.statusCode == 406) {
      Get.snackbar(
        'Not Acceptable (406)'.tr,
        'The ${res.data["detail"]} is already exist.'.tr,
        isDismissible: true,
        backgroundColor: Colors.white54,
      );
    } else {
      Get.snackbar(
        'Server error (500)'.tr,
        'There is server error please try again later.'.tr,
        isDismissible: true,
        backgroundColor: Colors.white54,
      );
    }
    btnController.stop();
  }
}
