import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/request/inbox/widgets/request_item/item_controller.dart';

class CompletedActions extends StatelessWidget {
  final String tag;
  const CompletedActions(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RequestItemController controller =
        Get.find<RequestItemController>(tag: tag);
    return Text(
      controller.request.value!.isAccepted!
          ? 'This request is completed'
          : 'This request is refused',
      style: TextStyle(
        color: ThemeColors.primaryDark,
        fontSize: 16,
      ),
    );
  }
}
