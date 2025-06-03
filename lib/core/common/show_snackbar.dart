import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content, [int duration = 800]) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        content: Text(content),
        duration: Duration(milliseconds: duration),
      ),
    );
}
