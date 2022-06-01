import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/models/pet.dart';
import 'package:petiapp/pages/request/widgets/pet_view.dart';
import 'package:petiapp/providers/request.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ConfirmWidget extends StatefulWidget {
  final Pet receiver, sender;
  const ConfirmWidget(this.receiver, this.sender, {Key? key}) : super(key: key);

  @override
  _ConfirmWidgetState createState() => _ConfirmWidgetState();
}

class _ConfirmWidgetState extends State<ConfirmWidget> {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  send() async {
    RequestProvider requestConnect = RequestProvider();
    Response res =
        await requestConnect.create(widget.receiver.id!, widget.sender.id!);
    if (res.statusCode == 200) {
      Get.back();
      Get.showSnackbar(GetBar(
        message: 'The request is sent',
        duration: const Duration(seconds: 3),
      ));
    } else if (res.statusCode == 406) {
      Get.back();
      Get.showSnackbar(GetBar(
        message: 'You have already sent request',
        duration: const Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(13),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(23)),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(13),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PetViewWidget(widget.receiver),
              PetViewWidget(widget.sender),
            ],
          ),
          const SizedBox(height: 11),
          Text(
            'By clicking this button, you know that we have no responsibility for what will happen between you and the other user'
                .tr,
            style: TextStyle(
              color: ThemeColors.primaryDarkMuted,
              fontWeight: FontWeight.bold,
              fontSize: kToolbarHeight * .23,
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
                      'Cancel',
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
                child: RoundedLoadingButton(
                  color: ThemeColors.firstPrimaryMuted,
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: kToolbarHeight * .3,
                    ),
                  ),
                  controller: btnController,
                  onPressed: () async {
                    btnController.start();
                    await send();
                    btnController.stop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
