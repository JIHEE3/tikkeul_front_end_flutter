import 'package:flutter/material.dart';
import '../models/dropdown_item.dart';

class GenderDropdownButton extends StatefulWidget {
  String selected = 'N';
  GenderDropdownButton({Key? key, this.selected = 'N'}) : super(key: key);

  @override
  State<GenderDropdownButton> createState() => _GenderDropdownButtonState();
}

class _GenderDropdownButtonState extends State<GenderDropdownButton> {
  final _items = [
    DropdownItem(label: '비공개', value: 'N'),
    DropdownItem(label: '남성', value: 'M'),
    DropdownItem(label: '여성', value: 'F'),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: widget.selected,
      items: _items.map((e) {
        return DropdownMenuItem(
          child: Text(e.label),
          value: e.value,
        );
      }).toList(),
      onChanged: (dynamic value) {
        setState(() {
          widget.selected = value;
        });
      },
    );
  }
}
