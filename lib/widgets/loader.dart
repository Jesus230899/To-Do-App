import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget showLoader() {
  if (Platform.isAndroid) {
    return const CircularProgressIndicator();
  } else {
    return const CupertinoActivityIndicator();
  }
}
