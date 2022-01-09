import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/theme/theme.dart';

Widget showLoader() {
  if (Platform.isAndroid) {
    return CircularProgressIndicator(color: AppColors.accentColor);
  } else {
    return const CupertinoActivityIndicator();
  }
}
