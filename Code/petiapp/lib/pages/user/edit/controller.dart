import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/models/user.dart';
import 'package:petiapp/providers/user.dart';
import 'package:petiapp/services/auth.dart';

class EditProfileController extends GetxController {
  TextEditingController first = TextEditingController();
  TextEditingController last = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController countryCode = TextEditingController();

  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() {
    User userData = AuthService.to.userData;
    first.text = userData.firstName!;
    last.text = userData.lastName!;
    email.text = userData.email!;
    if (userData.phone != null) {
      countryCode.text = userData.phone!.split(' ')[0];
      number.text = userData.phone!.split(' ')[1];
    }
  }

  Future<bool> save() async {
    if (!form.currentState!.validate()) return false;
    User user = AuthService.to.userData;
    UserProvider userConnect = UserProvider();
    Response res = await userConnect.updateAccount(
      email: user.email == email.text ? null : email.text,
      firstName: user.firstName == first.text ? null : first.text,
      lastName: user.lastName == last.text ? null : last.text,
      phone: number.text.isEmpty
          ? null
          : user.phone != null &&
                  user.phone!.split(' ')[1] == number.text &&
                  user.phone!.split(' ')[0] == countryCode.text
              ? null
              : countryCode.text + ' ' + int.parse(number.text).toString(),
    );
    if (res.statusCode == 200) {
      AuthService.to.saveData(User.fromMap(res.data));
      return true;
    }
    return false;
  }
}
