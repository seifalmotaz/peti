import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  final double? width;
  const DrawerButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: 40,
        width: width ?? double.infinity,
        margin: const EdgeInsets.only(bottom: 11),
        child: Icon(icon),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(19),
        ),
      ),
    );
  }
}
