import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/request/inbox/widgets/request_item/item_controller.dart';
import 'package:petiapp/pages/request/inbox/widgets/request_item/widgets/details.dart';

class RequestActionsWidget extends StatelessWidget {
  final String tag;
  const RequestActionsWidget(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RequestItemController controller =
        Get.find<RequestItemController>(tag: tag);
    return Wrap(
      children: [
        MaterialButton(
          elevation: 0,
          highlightElevation: 0,
          color: Colors.transparent,
          onPressed: () => controller.complete(),
          splashColor: Colors.grey[300],
          child: Text(
            'Marriage\nCompleted',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeColors.primaryDark,
              fontSize: 16,
            ),
          ),
        ),
        MaterialButton(
          elevation: 0,
          highlightElevation: 0,
          color: Colors.transparent,
          onPressed: () => controller.refuse(),
          splashColor: Colors.grey[300],
          child: Text(
            'Refuse',
            style: TextStyle(
              color: ThemeColors.primaryDark,
              fontSize: 16,
            ),
          ),
        ),
        MaterialButton(
          elevation: 0,
          highlightElevation: 0,
          color: Colors.transparent,
          onPressed: () => Get.bottomSheet(Details(controller.request.value!)),
          splashColor: Colors.grey[300],
          child: Text(
            'Details',
            style: TextStyle(
              color: ThemeColors.primaryDark,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
