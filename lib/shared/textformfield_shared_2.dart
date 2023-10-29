import 'package:flutter/material.dart';

class TextFormFieldShared extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? submit;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? lines;
  final bool obscureText;
  final void Function(String)? onChanged;

  const TextFormFieldShared({
    super.key,
    required this.label,
    this.prefixIcon,
    this.hintText = "",
    this.suffixIcon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.submit,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.lines,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        hintText: hintText,
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        suffixIcon: suffixIcon,
      ),
      controller: controller,
      keyboardType: keyboardType,
      onFieldSubmitted: submit,
      validator: validator,
      onTap: onTap,
      readOnly: readOnly,
      maxLines: lines,
      obscureText: obscureText,
      onChanged: onChanged,
    );
  }
}
