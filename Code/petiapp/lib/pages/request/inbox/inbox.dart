import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/pages/request/inbox/controller.dart';
import 'package:petiapp/pages/request/inbox/widgets/list.dart';

class RequestsInboxPage extends GetView<RequestsInboxController> {
  final String? petId;
  const RequestsInboxPage(this.petId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RequestsInboxController(petId));
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: BackButton(color: ThemeColors.primaryDark),
          title: Text(
            'Requests Inbox',
            style: TextStyle(
              fontFamily: 'CRFont',
              color: ThemeColors.primaryDark,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: ThemeColors.primaryDarkMuted,
            onTap: (int page) {
              switch (page) {
                case 0:
                  controller.getNewRequests();
                  break;
                case 1:
                  controller.getMyRequests();
                  break;
                case 2:
                  controller.getAcceptedRequests();
                  break;
                case 3:
                  controller.getRefusedRequests();
                  break;
                case 4:
                  controller.getCompletedRequests();
                  break;
              }
            },
            tabs: [
              Tab(
                child: Text(
                  'New'.tr,
                  style: TextStyle(
                    color: ThemeColors.primaryDark,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'My Requests'.tr,
                  style: TextStyle(
                    color: ThemeColors.primaryDark,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Accepted'.tr,
                  style: TextStyle(
                    color: ThemeColors.primaryDark,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Refused'.tr,
                  style: TextStyle(
                    color: ThemeColors.primaryDark,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Completed'.tr,
                  style: TextStyle(
                    color: ThemeColors.primaryDark,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const SafeArea(child: RequestsListPage()),
      ),
    );
  }
}
