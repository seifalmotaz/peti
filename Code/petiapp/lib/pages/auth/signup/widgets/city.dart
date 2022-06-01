import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/cities.dart';
import 'package:petiapp/pages/auth/controller.dart';

class SignUpCity extends StatefulWidget {
  final String countryName;
  const SignUpCity(this.countryName, {Key? key}) : super(key: key);

  @override
  _SignUpCityState createState() => _SignUpCityState();
}

class _SignUpCityState extends State<SignUpCity> {
  late List choosingList;

  @override
  void initState() {
    choosingList = cities[widget.countryName];
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
                    choosingList = cities[widget.countryName];
                  });
                } else {
                  setState(() {
                    choosingList = cities[widget.countryName]
                        .where((String element) => element.startsWith(value))
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
              String item = choosingList[index];
              return ListTile(
                onTap: () {
                  controller.location.addAll({'city': item});
                  controller.next();
                },
                leading: const Text(
                  '🏙️',
                  style: TextStyle(
                    fontSize: 21,
                    fontFamily: 'roboton',
                  ),
                ),
                horizontalTitleGap: 0,
                title: Text(
                  item.tr,
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
