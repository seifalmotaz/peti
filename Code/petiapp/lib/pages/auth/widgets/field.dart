import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController? fieldControler;
  final IconData? icon;
  final String? hint;
  final double? width;
  final TextInputType? inputType;
  final bool? obscureText;
  final TextCapitalization? textCapitalization;
  final String? Function(String? string)? validator;

  const AuthField(
      {this.fieldControler,
      this.hint,
      this.icon,
      this.inputType,
      this.obscureText,
      this.textCapitalization,
      this.width,
      this.validator,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(7),
          bottomLeft: Radius.circular(7),
        ),
        child: TextFormField(
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          keyboardType: inputType,
          controller: fieldControler,
          obscureText: obscureText ?? false,
          validator: validator == null ? null : (value) => validator!(value),
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'CourgetteFont',
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              top: 16,
              left: icon == null ? 11 : 0,
            ),
            prefixIcon: icon != null ? Icon(icon, color: Colors.white60) : null,
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white60),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white.withOpacity(.51),
                width: 3.5,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white.withOpacity(.51),
                width: 3.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white.withOpacity(.61),
                width: 3.5,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red.shade400,
                width: 2,
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red.shade400,
                width: 2,
              ),
            ),
            errorStyle: TextStyle(color: Colors.red.shade400),
          ),
        ),
      ),
    );
  }
}
