import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/countries.dart';

choosingCode() {
  return Get.bottomSheet(
    Container(
      color: Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * .4),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: countries.length,
        itemBuilder: (context, index) {
          Map country = countries[index];
          String flag = country['iso'].toUpperCase().replaceAllMapped(
              RegExp(r'[A-Z]'),
              (match) =>
                  String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
          return ListTile(
            onTap: () => Get.back(result: country['dial_code']),
            leading: Text(
              flag,
              style: const TextStyle(
                fontSize: 21,
                fontFamily: 'roboton',
              ),
            ),
            horizontalTitleGap: 0,
            title: Text(
              country['dial_code'],
              style: const TextStyle(
                fontSize: 21,
                fontFamily: 'roboton',
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              (country['name'] as String).tr,
              style: const TextStyle(
                fontSize: 21,
                fontFamily: 'roboton',
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    ),
  );
}
