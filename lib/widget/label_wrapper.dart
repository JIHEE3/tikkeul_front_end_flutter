import 'package:flutter/material.dart';

class LabelWrapperField extends StatelessWidget {
  final String label;
  final Widget childrenWidget;

  const LabelWrapperField({
    Key? key,
    required this.label,
    required this.childrenWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        childrenWidget,
        SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}
