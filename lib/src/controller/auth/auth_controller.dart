import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:iroots/bloc/bloclocalstorage/prefmanager.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/modal/auth/loginResponse.dart';
import 'package:iroots/src/modal/signup_user.dart';
import 'package:iroots/src/ui/dashboard/dashboard_screen.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

class AuthController extends GetxController {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerMobileNumber = TextEditingController();
  TextEditingController controllerOtp = TextEditingController();

  Map<String, String> roleIdToName = {
    '36e6c41d-1b91-4bd9-91ef-c267199ec0d5': 'Receptionist',
    '4e814119-47e3-4ec5-90df-667f07d86689': 'Staff',
    '5fa3abf4-1fad-435b-9020-cf3d3a4285f5': 'Library',
    '63284803-852e-4e2d-95f0-202d89a134b0': 'Student',
    'b58722cc-3579-4114-add4-6d550038b4a2': 'Developer',
    'c0bb6f5b-b3b9-4ddc-afd9-c1ab1d0a8722': 'Account',
    'e46afa07-2ce9-490b-8e7b-ed0fcb1727d9': 'Administrator',
  };

  @override
  void onInit() {
    if (kReleaseMode == false) {
      // controllerEmail.text = "luiesangmaa@gmail.com";
      // controllerPassword.text = "s5Tm8P2s";

      // controllerEmail.text = kReleaseMode ? "" : "stmary123@gmail.com";
      // controllerPassword.text = kReleaseMode ? "" : "St.Mary@123";
      // controllerEmail.text = kReleaseMode ? "" : "ABJebusChMarak";
      // controllerPassword.text = kReleaseMode ? "" : "G45QBp48";

      // controllerEmail.text = "melbonsangma278@gmail.com";
      // controllerPassword.text = "ieSLI4lx";

      // controllerEmail.text = "umaojhahome@gmail.com";
      // controllerPassword.text = "c4nYpB70";

      /// Student

      // controllerEmail.text = "BILAL@GMAIL.COM";
      // controllerPassword.text = "Ib8GrkoI";
      // controllerEmail.text = "fdsunny18@gmail.com";
      // controllerPassword.text = "55555";

      /// Admin
      //

      // controllerEmail.text = "Keorithamk@gmail.com";
      // controllerPassword.text = "2EQF5nnz";

      controllerEmail.text = "jaitha762@gmail.com";
      controllerPassword.text = "nirmala@123";

      // controllerEmail.text = "AbidaChMarak";
      // controllerPassword.text = "ieSLI4lx";

      // controllerEmail.text = "rathorevidhya99@gmail.com";
      // controllerPassword.text = "FerNdWWj";
      // controllerEmail.text = "jayrathore476@gmail.com";
      // controllerPassword.text = "QUITKFpd";
      // controllerEmail.text = "meenunaziyakhan@gmail.com";
      // controllerPassword.text = "Z3zknO9E";
      // controllerEmail.text = "";
      // controllerPassword.text = "RLD6E6pS";

      /// Staff

      // controllerEmail.text = "madhavijay21@gmail.com";
      // controllerPassword.text = "Mu7WiGuj";
      //

      // controllerEmail.text = "luiesangmaa@gmail.com";
      // controllerPassword.text = "s5Tm8P2s";

      // controllerEmail.text = "sangmaemeritha@gmail.com";
      // controllerPassword.text = "FDqgRHQN";
      // //
      // controllerEmail.text = "luiesangmaa@gmail.com";
      // controllerPassword.text = "s5Tm8P2s";

      // controllerEmail.text = "lsangmaemeritha@gmail.com";
      // controllerPassword.text = "FDqgRHQN";
      //
      controllerEmail.text = "St.Mary";
      controllerPassword.text = "St.Mary@123";
      //

      // controllerEmail.text = "jisbyantony13@gmail.com";
      // controllerPassword.text = "pCyZPc8T";
    }

    super.onInit();
  }

  Uint8List? imageRaw;
  RxBool showProgress = false.obs;
  String? fbUserProfile;
  String verificationId = '';
  final GetStorage box = Get.put(GetStorage());
  File? imageFile;
  String? userImage = '';
  SignupUser? userData;
  int clickCounter = 0;

  @override
  void onClose() {
    controllerName.clear();
    controllerEmail.clear();
    controllerPassword.clear();
    controllerMobileNumber.clear();
    controllerOtp.clear();
    super.onClose();
  }

  register() {
    _registerUser(
        name: controllerName.text,
        email: controllerEmail.text,
        password: controllerPassword.text);
  }

  login() {
    if (controllerEmail.text.isEmpty) {
      AppUtil.snackBar('Please enter email');
      return;
    }

    // if (!GetUtils.isEmail(controllerEmail.text)) {
    //   AppUtil.snackBar('Please enter valid email');
    //   return;
    // }

    if (controllerPassword.text.isEmpty) {
      AppUtil.snackBar('Please enter password');
      return;
    }

    _loginUser(email: controllerEmail.text, password: controllerPassword.text);
  }

  resetPassword() {
    if (controllerEmail.text.isEmpty) {
      AppUtil.snackBar('Please enter email to reset Password');
      return;
    }

    if (!GetUtils.isEmail(controllerEmail.text)) {
      AppUtil.snackBar('Please enter valid email to reset Password');
      return;
    }
    _resetPass(email: controllerEmail.text);
  }

  Future<void> _registerUser(
      {required String name,
      required String email,
      required String password}) async {}

  Future<void> _loginUser({
    required String email,
    required String password,
  }) async {
    _showProgress();

    Map<String, String> credentials = {
      'email': email,
      'password': password,
    };

    String jsonCredentials = jsonEncode(credentials);

    try {
      final response = await http.post(
        Uri.parse("${baseUrlName}Auth/CreateEmployeeLogin"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonCredentials,
      );

      if (response.statusCode == 200) {
        var loginResponse = loginResponseFromJson(response.body);
        if (loginResponse.responseCode == "200" && loginResponse.data != null) {
          print(response.body);
          box.write("accessToken", loginResponse.data!.accessToken);
          box.write("isUserLogin", true);
          box.write("userId", loginResponse.data!.userId);

          String userRole = roleIdToName[loginResponse.data!.userRoleId]!;
          box.write("userRole", userRole);
          await PrefManager.setAdditionalInfo(loginResponse.additionalData!);

          await PrefManager.setToken(loginResponse.data!.accessToken!);

          String jsonstring2 = loginResponse.additionalData!;
          List<dynamic> studentList = jsonDecode(jsonstring2);
          String? nameStudent = studentList[0]["Name"];
          String? classId = studentList[0]["ClassId"].toString();
          await PrefManager.setName(nameStudent);
          await PrefManager.setClassId(classId);
          _hideProgress();
          Get.offAll(() => const DashBoardPageScreen());
        } else if (loginResponse.responseCode == "500") {
          _hideProgress();
          AppUtil.snackBar("Something went wrong");
        } else {
          _hideProgress();
          AppUtil.snackBar(loginResponse.msg!);
        }
      } else {
        _hideProgress();
        AppUtil.snackBar('Something went wrong');
      }
    } catch (error) {
      _hideProgress();
      AppUtil.snackBar('$error');
    }
  }

  void _showProgress() {
    showProgress.value = true;
  }

  void _hideProgress() {
    showProgress.value = false;
  }
}

void _resetPass({required String email}) {}
