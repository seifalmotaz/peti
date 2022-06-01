import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/models/request.dart';
import 'package:petiapp/pages/pet/read/read.dart';
import 'package:petiapp/pages/request/inbox/widgets/request_item/item_controller.dart';
import 'package:petiapp/pages/request/inbox/widgets/request_item/widgets/actions.dart';
import 'package:petiapp/pages/request/inbox/widgets/request_item/widgets/completed.dart';
import 'package:petiapp/pages/request/inbox/widgets/request_item/widgets/details.dart';
import 'package:petiapp/pages/request/inbox/widgets/request_item/widgets/new_actions.dart';
import 'package:petiapp/pages/request/widgets/pet_view.dart';
import 'package:petiapp/services/auth.dart';

class RequestItemWidget extends StatelessWidget {
  final Request request;
  const RequestItemWidget(this.request, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RequestItemController controller =
        Get.put(RequestItemController(request), tag: request.id);
    return Obx(() {
      bool isOwned = request.sender.owner!.id! == AuthService.to.userData.id!;
      return IgnorePointer(
        ignoring: controller.request.value!.isCompleted,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PetViewWidget(request.receiver),
                GestureDetector(
                  onTap: () => Get.to(() => ReadPetPage(request.sender.id!)),
                  child: PetViewWidget(request.sender),
                ),
              ],
            ),
            const SizedBox(height: 11),
            if (!isOwned &&
                request.isAccepted == null &&
                request.isCompleted == false)
              NewRequestActionsWidget(request.id),
            if (!isOwned &&
                request.isAccepted == true &&
                request.isCompleted == false)
              RequestActionsWidget(request.id),
            if (!isOwned && request.isCompleted == true)
              CompletedActions(request.id),
            if (isOwned && request.isCompleted == false)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    elevation: 0,
                    highlightElevation: 0,
                    color: Colors.transparent,
                    onPressed: () =>
                        Get.bottomSheet(Details(controller.request.value!)),
                    splashColor: Colors.grey[300],
                    child: Text(
                      'Details',
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
                    onPressed: () => controller.delete(),
                    splashColor: Colors.grey[300],
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: ThemeColors.primaryDark,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    });
  }
}
