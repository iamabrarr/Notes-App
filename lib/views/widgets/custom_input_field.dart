import 'package:flutter/material.dart';
import 'package:notes/views/constants/consts.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.maxLines,
    required this.isTitle,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool isTitle;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
          fontWeight: isTitle ? FontWeight.w600 : FontWeight.w500,
          color: isTitle ? kSecondaryColor : Colors.black),
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
            color: isTitle ? kSecondaryColor : Colors.black,
            fontWeight: isTitle ? FontWeight.w600 : FontWeight.w400),
        labelStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}
