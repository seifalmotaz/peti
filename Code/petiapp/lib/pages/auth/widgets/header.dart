import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  const Header(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Peti',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'CRFont',
            fontSize: 48,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white60,
            fontFamily: 'CRFont',
            fontSize: 21,
          ),
        ),
      ],
    );
  }
}
