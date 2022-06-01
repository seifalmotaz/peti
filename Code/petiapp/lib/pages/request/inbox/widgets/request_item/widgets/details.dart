import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/theme.dart';
import 'package:petiapp/functions/local_date.dart';
import 'package:petiapp/models/request.dart';
import 'package:petiapp/pages/user/profile/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatelessWidget {
  final Request request;
  const Details(this.request, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAccepted = request.isAccepted == true;
    return Container(
      margin: const EdgeInsets.all(13),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Get.to(() => ProfilePage(request.sender.owner!.id!)),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: request.sender.owner!.avatar!,
                  imageBuilder: (context, imageProvider) {
                    return CircleAvatar(
                      radius: Get.width * .1,
                      backgroundImage: imageProvider,
                    );
                  },
                ),
                const SizedBox(width: 7),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.sender.owner!.username.length > 15
                          ? request.sender.owner!.username.substring(0, 15) +
                              '...'
                          : request.sender.owner!.username,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: ThemeColors.primaryDark,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Email: ' + request.sender.owner!.email!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Last login: ' +
                          getLocalDate(request.sender.owner!.lastLogin!),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 11),
          Text(
            !request.sender.owner!.isLocation
                ? 'Location: Unknown'.tr
                : 'Location: ${request.sender.owner!.location!.region != null ? request.sender.owner!.location!.region! + ", " : ""}${request.sender.owner!.location!.city!}, ${request.sender.owner!.location!.country}',
            style: const TextStyle(
              color: Colors.grey,
              fontFamily: 'roboton',
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 11),
          Row(
            children: [
              Flexible(
                child: Opacity(
                  opacity: !isAccepted ? .51 : 1,
                  child: Container(
                    width: double.infinity,
                    height: kTextTabBarHeight,
                    decoration: BoxDecoration(
                      color: ThemeColors.secondPrimaryMuted,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(13),
                        splashColor: ThemeColors.secondPrimary,
                        onTap: () async {
                          if (isAccepted) {
                            var telUrl = "tel://${request.sender.owner!.phone}";
                            await canLaunch(telUrl)
                                ? launch(telUrl)
                                : Get.showSnackbar(GetBar(
                                    message: "Sorry we can not open the app",
                                    duration: const Duration(seconds: 3),
                                  ));
                          } else {
                            Get.showSnackbar(GetBar(
                              duration: const Duration(seconds: 3),
                              message:
                                  'Your are not allowed to see phone number before you accept it.',
                            ));
                          }
                        },
                        child: const Center(
                          child: Text(
                            'Phone',
                            style: TextStyle(
                              fontSize: kTextTabBarHeight * .37,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 7),
              Flexible(
                child: Opacity(
                  opacity: !isAccepted ? .51 : 1,
                  child: Container(
                    width: double.infinity,
                    height: kTextTabBarHeight,
                    decoration: BoxDecoration(
                      color: const Color(0xFF25d366),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(13),
                        splashColor: const Color(0xFF128c7e),
                        onTap: () async {
                          if (isAccepted) {
                            var whatsappUrl =
                                "whatsapp://send?phone=20${request.sender.owner!.phone}";
                            await canLaunch(whatsappUrl)
                                ? launch(whatsappUrl)
                                : Get.showSnackbar(GetBar(
                                    message: "Sorry we can not open the app",
                                    duration: const Duration(seconds: 3),
                                  ));
                          } else {
                            Get.showSnackbar(GetBar(
                              duration: const Duration(seconds: 3),
                              message:
                                  'Your are not allowed to see phone number before you accept it.',
                            ));
                          }
                        },
                        child: const Center(
                          child: Text(
                            'WhatsApp',
                            style: TextStyle(
                              fontSize: kTextTabBarHeight * .37,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
