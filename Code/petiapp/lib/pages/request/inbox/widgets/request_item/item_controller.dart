import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/models/request.dart';
import 'package:petiapp/pages/request/inbox/controller.dart';
import 'package:petiapp/providers/request.dart';

class RequestItemController extends GetxController {
  RequestItemController(Request r) {
    request.value = r;
  }

  Rxn<Request> request = Rxn<Request>(null);
  RequestProvider requestConnect = RequestProvider();

  acceptIt() async {
    Response res = await requestConnect.accept(request.value!.id, true);
    if (res.statusCode == 200) {
      request.update((val) {
        val!.isAccepted = true;
      });
    }
  }

  refuse() async {
    Response res = await requestConnect.accept(request.value!.id, false);
    if (res.statusCode == 200) {
      request.update((val) {
        val!.isAccepted = false;
        val.isCompleted = true;
      });
    }
  }

  complete() async {
    Response res = await requestConnect.complete(request.value!.id);
    if (res.statusCode == 200) {
      request.update((val) {
        val!.isCompleted = true;
      });
    }
  }

  delete() async {
    Response res = await requestConnect.delete(request.value!.id);
    RequestsInboxController requestInboxController =
        Get.find<RequestsInboxController>();
    if (res.statusCode == 200) {
      requestInboxController.requests
          .removeWhere((element) => element.id == request.value!.id);
    }
  }

  accept() {
    return Get.bottomSheet(Container(
      padding: const EdgeInsets.all(13),
      margin: const EdgeInsets.all(13),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(23)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'By clicking this button, you know that we have no responsibility for what will happen between you and the other user'
                  .tr,
              style: TextStyle(
                color: ThemeColors.primaryDarkMuted,
                fontWeight: FontWeight.bold,
                fontSize: kToolbarHeight * .3,
              ),
            ),
          ),
          const SizedBox(height: 11),
          Row(
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Center(
                    child: Text(
                      'Cancel'.tr,
                      style: TextStyle(
                        color: ThemeColors.primaryDarkMuted,
                        fontWeight: FontWeight.bold,
                        fontSize: kToolbarHeight * .3,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: GestureDetector(
                  onTap: () async {
                    await acceptIt();
                    Get.back();
                  },
                  child: Center(
                    child: Text(
                      'Accept'.tr,
                      style: TextStyle(
                        color: ThemeColors.primaryDarkMuted,
                        fontWeight: FontWeight.bold,
                        fontSize: kToolbarHeight * .3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
