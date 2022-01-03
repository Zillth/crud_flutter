import 'package:flutter/material.dart';

class ButtonLabelWidget extends StatelessWidget {
  final String text;
  const ButtonLabelWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
    );
  }
}
