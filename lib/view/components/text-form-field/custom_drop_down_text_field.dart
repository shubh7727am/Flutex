// TODO Implement this library.

import 'package:flutter/material.dart';

class CustomDropDownTextField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String?>? onChanged;
  final List<DropdownMenuItem<String>> items;
  final Color dropDownColor;
  final TextEditingController controller;

  const CustomDropDownTextField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.items,
    required this.dropDownColor,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      dropdownColor: dropDownColor,
      items: items,
      onChanged: (value) {
        onChanged?.call(value);
        if (value != null) {
          controller.text = value;
        }
      },
    );
  }
}
