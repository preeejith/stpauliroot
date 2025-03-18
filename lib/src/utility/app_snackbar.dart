import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iroots/src/utility/app_colors.dart';

toast(message, success) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor:
        success == false ? AppColors.redColor : AppColors.greenColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
