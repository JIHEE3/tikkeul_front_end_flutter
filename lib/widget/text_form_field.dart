import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widget/label_wrapper.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  const CommonTextFormField(
      {Key? key,
      this.controller,
      required this.label,
      required this.onSaved,
      required this.validator,
      this.onChanged,
      this.obscureText = false,
      this.decoration,
      this.keyboardType,
      this.inputFormatters,
      this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LabelWrapperField(
      label: label,
      childrenWidget: Container(
        alignment: Alignment.centerLeft,
        child: TextFormField(
          controller: controller,
          onSaved: onSaved,
          validator: validator,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: decoration,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
        ),
      ),
    );
  }
}
