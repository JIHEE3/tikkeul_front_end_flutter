import 'package:flutter/material.dart';

renderTextFormField({
  TextEditingController? controller,
  required String label,
  required FormFieldSetter onSaved,
  FormFieldValidator? validator,
  ValueChanged<String>? onChanged,
  bool obscureText = false,
  InputDecoration? decoration,
}) {
  return Column(
    children: [
      Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      TextFormField(
          controller: controller,
          onSaved: onSaved,
          validator: validator,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: decoration),
      SizedBox(
        height: 16.0,
      ),
    ],
  );
}
