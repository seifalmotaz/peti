import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/request/inbox/controller.dart';
import 'package:petiapp/pages/request/inbox/widgets/request_item/item.dart';

class RequestsListPage extends GetView<RequestsInboxController> {
  const RequestsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<RequestsInboxController>();
    return Obx(() {
      if (controller.loading.value) {
        return Center(
          child: SpinKitRing(
            color: ThemeColors.primaryDarkMuted,
            lineWidth: 3,
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.all(13),
        itemCount: controller.requests.length,
        itemBuilder: (context, index) =>
            RequestItemWidget(controller.requests[index]),
      );
    });
  }
}
