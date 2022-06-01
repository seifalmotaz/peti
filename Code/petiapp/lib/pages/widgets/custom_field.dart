import 'package:flutter/material.dart';
import 'package:petiapp/constants/theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String? string)? validator;
  final String? labelText;
  final String? hintText;
  final bool readOnly;
  final bool labelBahave;
  final bool smallHint;
  final Function? onTap;
  final String? init;
  const CustomTextField({
    Key? key,
    this.controller,
    this.textInputType,
    this.validator,
    this.hintText,
    this.labelText,
    this.readOnly = false,
    this.labelBahave = true,
    this.smallHint = true,
    this.init,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      controller: controller,
      readOnly: readOnly,
      validator: validator == null ? null : (string) => validator!(string),
      onTap: onTap == null ? null : () => onTap!(),
      initialValue: init,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(
          color: ThemeColors.primaryDark,
          fontWeight: FontWeight.bold,
          fontFamily: 'roboton',
        ),
        hintStyle: !smallHint ? null : const TextStyle(fontSize: 11),
        floatingLabelBehavior: labelBahave
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
        contentPadding: const EdgeInsets.all(11),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade200,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeColors.primaryDarkMuted,
            width: 2,
          ),
        ),
      ),
    );
  }
}
