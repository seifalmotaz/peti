import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseType extends StatefulWidget {
  const ChooseType({Key? key}) : super(key: key);

  @override
  _ChooseTypeState createState() => _ChooseTypeState();
}

class _ChooseTypeState extends State<ChooseType> {
  List<String> list = [];
  List<String> choosingList = [];
  bool loading = true;

  @override
  void initState() {
    list.addAll(['Dog', 'Cat', 'Horse', 'Rabbit', 'Bird']);
    choosingList = list;
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
                      choosingList = list;
                    });
                  } else {
                    setState(() {
                      choosingList = list
                          .where((element) => element.startsWith(value))
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
                  onTap: () => Get.back(result: item),
                  title: Text(
                    item.tr,
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
