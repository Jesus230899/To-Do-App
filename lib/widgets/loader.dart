// important!
// This fie contains recyclable loaders used in the app

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/theme/theme.dart';

// The function showLoader return a widget indicator used in operative systems.
Widget showLoader() {
  if (Platform.isAndroid) {
    return CircularProgressIndicator(color: AppColors.accentColor);
  } else {
    return const CupertinoActivityIndicator();
  }
}
