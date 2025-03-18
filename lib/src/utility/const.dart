import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConstClass {
  static Color themeColor = const Color(0xff1575FF);
  static Color selectedColor = const Color(0xff1575FF);
  static Color unSelectedColor = const Color(0xff475569);
  static Color bottomTabColor = const Color(0xff111111);
  static Color unselectedColor = const Color(0xffD9D9D9);
  static Color dashBoardColor = const Color(0xff1575FF);

  static String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());



  static Widget widgetTextField(
      {required Widget? prefixIcon,
      required TextEditingController controllerEmail,
      required String hint,
      required TextInputType? keyboardType,
      required int maxLength,
      bool? isPassword}) {
    return TextFormField(
      obscureText: isPassword ?? false,
      controller: controllerEmail,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hint,
        counterText: '',
        contentPadding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
        fillColor: Colors.white,
        filled: true,
        hintStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0.2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0.2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      style: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
      keyboardType: keyboardType,
      // textInputAction: TextInputAction.next,
      maxLength: maxLength,
    );
  }
}
