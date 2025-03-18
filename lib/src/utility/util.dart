import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iroots/src/modal/attendance/staffModalClass.dart';
import 'package:iroots/src/utility/const.dart';

extension StringExtensions on String? {
  bool get isNotNullOrEmpty =>
      toString().toLowerCase().trim() != "null" &&
          this!.isNotEmpty &&
          toString().toLowerCase().trim() != "n/a";
}

class AppUtil {
  static Widget customText(
      {double? structHeight,
      TextStyle? style,
      TextOverflow? overflow,
      String? text,
      int? maxLines,
      TextAlign? textAlign,
      String? font,
      bool? isShow,
      bool? isVisible,
      void Function()? onPressed}) {
    return Text(
        overflow: overflow ?? TextOverflow.visible,
        strutStyle: StrutStyle(height: structHeight),
        text ?? "",
        maxLines: maxLines,
        textAlign: textAlign,
        style: style ?? const TextStyle());
  }

  static Widget widgetText(
      {double? structHeight,
      TextDecoration? textDecoration,
      TextOverflow? overflow,
      String? text,
      int? maxLines,
      TextAlign? textAlign,
      String? font,
      double? fontSize,
      double? height,
      Color? textColor,
      double? letterSpace,
      FontStyle? fontStyle,
      FontWeight? textFontWeight,
      bool? isShow,
      bool? isVisible,
      void Function()? onPressed}) {
    return Text(
      overflow: overflow ?? TextOverflow.visible,
      strutStyle: StrutStyle(height: structHeight),
      text ?? "",
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        decoration: textDecoration,
        letterSpacing: letterSpace,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontSize: fontSize,
        color: textColor,
        fontWeight: textFontWeight,
        height: height,
      ),
    );
  }

  static Color getFabBackgroundColor(int currentPage) {
    switch (currentPage) {
      case 0:
        return const Color(0xfff16505);
      case 1:
        return const Color(0xffe0ad01);
      case 2:
        return const Color(0xff0685df);
      default:
        return const Color(0xfff16505);
    }
  }

  static snackBar(String? title) {
    Get.snackbar(title!, '',
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red[500],
        colorText: Colors.white);
  }

  static customDropDown(
      GetxController? logic,
      String? dropDownText,
      String? hintText,
      List<StaffData> staffDataList,
      void Function(StaffData) onChanged,
      StaffData? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppUtil.customText(
          text: dropDownText,
          style: TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              fontSize: 14),
        ),
        SizedBox(
          height: 2,
        ),
        DropdownButtonFormField<StaffData>(
          icon: SvgPicture.asset(
            "assets/icons/arrowdown_icon.svg",
            height: 20,
            width: 20,
          ),
          value: value,
          items: staffDataList.map((item) {
            return DropdownMenuItem<StaffData>(
                value: item,
                child: item.staffName!.isNotEmpty && item.staffName != ""
                    ? AppUtil.customText(
                        text: item.staffName,
                        style: TextStyle(
                            color: const Color(0xff0F172A),
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      )
                    : const SizedBox());
          }).toList(),
          onChanged: (newValue) {
            onChanged(newValue!);
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: TextStyle(
                color: const Color(0xff0F172A),
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w400,
                fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xff94A3B8),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xff94A3B8),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xff94A3B8),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static customOutlinedButton(
      ButtonStyle buttonStyle, Widget widget, Function() onPressed) {
    return OutlinedButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: widget,
    );
  }

  static customDropDown1(
    String? title,
    String? buttonValue,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppUtil.customText(
          text: title,
          style: TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              fontSize: 14),
        ),
        SizedBox(
          height: 2,
        ),
        SizedBox(
          width: Get.width,
          child: customOutlinedButton(
              OutlinedButton.styleFrom(
                side: const BorderSide(width: 1, color: Color(0xff94A3B8)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppUtil.customText(
                      text: buttonValue,
                      style: TextStyle(
                          color: const Color(0xff0F172A),
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    SvgPicture.asset(
                      "assets/icons/arrowdown_icon.svg",
                      height: 20,
                      width: 20,
                    ),
                  ],
                ),
              ),
              () {}),
        )
      ],
    );
  }

  static Center noDataFound(String? text) {
    return Center(
      child: AppUtil.customText(
        text: text,
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w700,
            fontSize: 16),
      ),
    );
  }

  static Future showAlertDialog({void Function()? onPressed}) {
    return Get.dialog(
        barrierDismissible: false,
        Dialog(
          backgroundColor: Colors.transparent,
          child: WillPopScope(
            onWillPop: () async => false,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppUtil.customText(
                      textAlign: TextAlign.center,
                      text: "Your Session has expired.Please log in again.",
                      style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: onPressed,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: AppUtil.customText(
                          textAlign: TextAlign.center,
                          text: "OK",
                          style: TextStyle(
                              color: ConstClass.themeColor,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
