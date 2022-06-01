import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:petiapp/constants/theme.dart';

List<String> translations = ['العربيه_ar_EG', 'English_en_UK'];

Widget changeLang() {
  return Container(
    color: Colors.white,
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: translations.length,
      itemBuilder: (context, index) {
        String lang = translations[index];
        String langName = lang.split('_')[0];
        String langCode = lang.split('_')[1];
        String langCountry = lang.split('_')[2];
        return ListTile(
          onTap: () async {
            GetStorage getStorage = GetStorage();
            await getStorage.write('lang', '$langCode $langCountry');
            Get.updateLocale(Locale(langCode, langCountry));
          },
          leading: Text(
            langCode.toUpperCase(),
            style: TextStyle(
              color: ThemeColors.primaryDark.withOpacity(.61),
              fontWeight: FontWeight.w600,
              fontSize: kToolbarHeight * .3,
            ),
          ),
          title: Text(
            langName,
            style: TextStyle(
              color: ThemeColors.primaryDark,
              fontWeight: FontWeight.w600,
              fontSize: kToolbarHeight * .3,
            ),
          ),
          trailing: Text(
            langCountry,
            style: TextStyle(
              color: ThemeColors.primaryDark.withOpacity(.61),
              fontWeight: FontWeight.w600,
              fontSize: kToolbarHeight * .3,
            ),
          ),
        );
      },
    ),
  );
}
