import 'package:flutter/material.dart';

class EditingTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const EditingTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      controller: controller,
      validator: (value) {
        if (value == null) {
          return "$hintText is missing";
        } else if (value.trim() == "") {
          return "$hintText is missing";
        }
        return null;
      },
    );
  }
}
