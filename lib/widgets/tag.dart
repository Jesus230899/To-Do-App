// important!
// This fie contains recyclable tags used in the app.

import 'package:flutter/material.dart';
import 'package:to_do_app/theme/theme.dart';

//  The function customTag has obligatory params for proper operations.
Widget customTag(
    {@required Function onPressed,
    @required bool isSelected,
    @required String name}) {
  return GestureDetector(
    // Assign the Funtion
    onTap: onPressed,
    child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          // If is select, change the color of backgroundColor
          color: isSelected ? AppColors.accentColor : Colors.white,
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(name,
              // If is select, change the color of the text
              style:
                  TextStyle(color: isSelected ? Colors.white : Colors.black)),
        ))),
  );
}
