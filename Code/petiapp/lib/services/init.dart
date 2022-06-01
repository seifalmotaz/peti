import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:petiapp/providers/user.dart';

import 'auth.dart';

class InitApp {
  static Future<InitRes> initAuthService() async {
    await GetStorage.init();
    // authService
    AuthService authService =
        await Get.putAsync<AuthService>(() async => AuthService());
    if (authService.isAuthenticated.value) {
      Response res = await UserProvider().updateLastLogin();
      if (res.statusCode == 200) {
        if (res.data['version'] != '1.5.4' && res.data['important'] == true) {
          authService.isUpdated.value = false;
        }
      } else if (res.statusCode == 401) {
        authService.isAuthenticated.value = false;
      }
    }
    return InitRes(
      authService.isAuthenticated.value,
      authService.isUpdated.value,
    );
  }

  static initTranslation() {
    GetStorage getStorage = GetStorage();
    String? local = getStorage.read('lang');
    if (local != null) {
      return Locale(local.split(' ')[0], local.split(' ')[1]);
    } else {
      return null;
    }
  }
}

class InitRes {
  final bool isAuthenticated;
  final bool isUpdated;
  InitRes(this.isAuthenticated, this.isUpdated);
}
