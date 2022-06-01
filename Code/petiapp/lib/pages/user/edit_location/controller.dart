import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/models/location.dart';
import 'package:petiapp/providers/user.dart';
import 'package:petiapp/services/auth.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditLocationController extends GetxController {
  Rx<Map?> countryMap = Rx<Map?>(null);
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController region = TextEditingController();
  RxBool locationLoading = false.obs;
  RxBool locationPositioned = false.obs;
  // Rx<Position?> position = Rx<Position?>(null);
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  @override
  void onInit() {
    getData();
    super.onInit();
    // getLocation();
  }

  Future<bool> save() async {
    UserProvider userConnect = UserProvider();
    Response res = await userConnect.updateLocation(
      country: countryMap.value == null ? null : countryMap.value!['name'],
      city: city.text.isEmpty ? null : countryMap.value!['city'],
      region: region.text.isEmpty ? null : region.text,
      iso: countryMap.value == null ? null : countryMap.value!['iso'],
      // latitude: !locationPositioned.value ? null : position.value!.latitude,
      // longitude: !locationPositioned.value ? null : position.value!.longitude,
    );
    if (res.statusCode == 200) {
      AuthService.to.userData.location = Location.fromMap(res.data);
      AuthService.to.saveData(AuthService.to.userData);
      return true;
    }
    return false;
  }

  getData() {
    if (AuthService.to.userData.isLocation) {
      country.text = (AuthService.to.userData.location!.country ?? '').tr;
      city.text = (AuthService.to.userData.location!.city ?? '').tr;
      region.text = AuthService.to.userData.location!.region ?? '';
      countryMap.value = {
        'name': AuthService.to.userData.location!.country!,
        'iso': AuthService.to.userData.location!.iso!,
      };
      if (AuthService.to.userData.location!.isSpecific) {
        locationPositioned.value = true;
      }
    }
  }

  // getLocation() async {
  //   locationLoading.value = true;
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     Get.showSnackbar(GetBar(
  //       duration: Duration(seconds: 3),
  //       message: 'Location services are disabled.'.tr,
  //     ));
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission != LocationPermission.always ||
  //       permission != LocationPermission.whileInUse) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       Get.showSnackbar(GetBar(
  //         duration: Duration(seconds: 3),
  //         message: 'Location permissions are denied'.tr,
  //       ));
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     Get.showSnackbar(GetBar(
  //       duration: Duration(seconds: 3),
  //       message:
  //           'Location permissions are permanently denied, we cannot request permissions.'
  //               .tr,
  //     ));
  //   }
  //   if (serviceEnabled &&
  //       (permission == LocationPermission.always ||
  //           permission == LocationPermission.whileInUse))
  //     position.value = await Geolocator.getCurrentPosition();

  //   locationLoading.value = false;
  //   if (serviceEnabled &&
  //       (permission == LocationPermission.always ||
  //           permission == LocationPermission.whileInUse)) if (position.value !=
  //       null) locationPositioned.value = true;
  // }
}
