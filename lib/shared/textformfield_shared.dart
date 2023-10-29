import 'package:flutter/material.dart';

Widget customTextFormField(
    {required TextEditingController? controller,
    required TextInputType? keyboardType,
    ValueChanged<String>? submit,
    required FormFieldValidator<String> validator,
    required String label,
    required String hintText,
    required IconData prefixIcon,
    void Function(String)? onChanged,
    Widget? suffixIcon,
    GestureTapCallback? onTap,
    required bool readOnly,
    required bool obscureText,
    int? lines}) {
  return Expanded(
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon),
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
    ),
  );
}
