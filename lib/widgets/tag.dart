import 'package:flutter/material.dart';
import 'package:to_do_app/theme/theme.dart';

Widget customTag(
    {@required Function onPressed,
    @required bool isSelected,
    @required String name}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          color: isSelected ? AppColors.accentColor : Colors.white,
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(name,
              style:
                  TextStyle(color: isSelected ? Colors.white : Colors.black)),
        ))),
  );
}
