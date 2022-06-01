import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/countries.dart';
import 'package:petiapp/pages/auth/controller.dart';

class SignUpCountry extends StatefulWidget {
  const SignUpCountry({Key? key}) : super(key: key);

  @override
  State<SignUpCountry> createState() => _SignUpCountryState();
}

class _SignUpCountryState extends State<SignUpCountry> {
  late List choosingList;

  @override
  void initState() {
    choosingList = countries;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FormController controller = Get.find<FormController>();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: BackButton(
            color: const Color(0xFFB4B4B4),
            onPressed: () => controller.previous(),
          ),
          floating: true,
          elevation: 0,
          forceElevated: true,
          backgroundColor: Colors.transparent,
          title: Container(
            width: Get.width * .8,
            padding: const EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              color: Colors.grey.shade100.withOpacity(.13),
              borderRadius: BorderRadius.circular(21),
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(
                color: Colors.grey[600],
                fontFamily: 'Pattaya',
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 16),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFFB4B4B4),
                ),
                hintText: 'Search...',
                hintStyle: TextStyle(
                  color: Color(0xFFB4B4B4),
                ),
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    choosingList = countries;
                  });
                } else {
                  setState(() {
                    choosingList = countries
                        .where((element) =>
                            element['name'].toString().startsWith(value))
                        .toList();
                  });
                }
              },
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) {
              Map item = choosingList[index];
              String countryCode = item['iso'];
              String flag = countryCode.toUpperCase().replaceAllMapped(
                  RegExp(r'[A-Z]'),
                  (match) => String.fromCharCode(
                      match.group(0)!.codeUnitAt(0) + 127397));
              return ListTile(
                onTap: () {
                  controller.location.addAll({
                    'country': item['name'],
                    'iso': countryCode,
                    'dial_code': item['dial_code'],
                  });
                  controller.next();
                },
                leading: Text(
                  flag,
                  style: const TextStyle(
                    fontSize: 21,
                    fontFamily: 'roboton',
                  ),
                ),
                horizontalTitleGap: 0,
                title: Text(
                  (item['name'] as String).tr,
                  style: const TextStyle(
                    fontSize: 21,
                    fontFamily: 'roboton',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            },
            childCount: choosingList.length,
          ),
        )
      ],
    );
  }
}
