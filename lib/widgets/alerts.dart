// important!
// This fie contains recyclable alerts used in the app

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// I specify the parameters are obligatory in this Widget for proper operation
showDialogInfo(
    {@required BuildContext context,
    @required String title,
    @required String description,
    Function onPressed}) {
  // This conditional is used to identify the operative system.
  if (Platform.isIOS) {
    // Return dialog from cupertino library
    return showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              content: Text(description),
              actions: [
                // If onPressed is null, this action is hide
                Visibility(
                  visible: onPressed != null,
                  child: CupertinoDialogAction(
                    child: const Text('Cancelar'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                CupertinoDialogAction(
                  child: const Text('Entendido'),
                  onPressed: onPressed ?? () => Navigator.pop(context),
                ),
              ],
            ));
  } else {
    // Return dialog from material
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              title: Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              content: Text(description),
              actions: [
                // If onPressed is null, this action is hide.
                Visibility(
                  visible: onPressed != null,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: const Text('Cancelar'),
                    ),
                  ),
                ),
                InkWell(
                  onTap: onPressed ?? () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: const Text('Entendido'),
                  ),
                )
              ],
            ));
  }
}
