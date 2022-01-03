import 'package:flutter/material.dart';

class SnackBarSuccess {
  final String text;
  const SnackBarSuccess({required this.text});

  SnackBar get snackBar => SnackBar(
        backgroundColor: Colors.green[200],
        content: Text(
          text,
          style: const TextStyle(fontSize: 16.0, color: Colors.black),
        ),
        action: SnackBarAction(
          textColor: Colors.black,
          label: 'Aceptar',
          onPressed: () {},
        ),
      );
}

class SnackBarFail {
  final String text;
  const SnackBarFail({required this.text});

  SnackBar get snackBar => SnackBar(
        backgroundColor: Colors.red[200],
        content: Text(
          text,
          style: const TextStyle(fontSize: 16.0, color: Colors.black),
        ),
        action: SnackBarAction(
          textColor: Colors.black,
          label: 'Aceptar',
          onPressed: () {},
        ),
      );
}
