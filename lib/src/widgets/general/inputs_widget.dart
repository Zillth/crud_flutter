import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData iconData;
  final String label;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  const InputWidget(
      {Key? key,
      required this.controller,
      required this.iconData,
      required this.label,
      this.textInputType = TextInputType.text,
      this.textInputAction = TextInputAction.done,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      maxLines: null,
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(icon: Icon(iconData), labelText: label),
      textInputAction: textInputAction,
      style: const TextStyle(fontSize: 17.0),
    );
  }
}
