import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showDialogInfo(
    {@required BuildContext context,
    @required String title,
    @required String description,
    Function onPressed}) {
  if (Platform.isIOS) {
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
