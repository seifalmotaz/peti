import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petiapp/constants/countries.dart';

class ChooseCountry extends StatefulWidget {
  const ChooseCountry({Key? key}) : super(key: key);

  @override
  _ChooseCountryState createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  late List choosingList;

  @override
  void initState() {
    choosingList = countries;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).copyWith().size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const BackButton(color: Color(0xFFB4B4B4)),
            floating: true,
            elevation: .81,
            forceElevated: true,
            backgroundColor: Colors.white,
            title: Container(
              width: size.width * .8,
              padding: const EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                color: Colors.grey[100],
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
                  onTap: () => Get.back(result: item),
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
                    ),
                  ),
                );
              },
              childCount: choosingList.length,
            ),
          )
        ],
      ),
    );
  }
}
