// important!
// This fie contains recyclable snakBar used in the app
import 'package:flutter/material.dart';

// The function showSnakBar has obligatory params for proper operation
showSnakBar(
    {@required BuildContext context, @required Color color, @required text}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // Specify the duration
      duration: const Duration(seconds: 2),
      // Assign color from params
      backgroundColor: color,
      content: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
