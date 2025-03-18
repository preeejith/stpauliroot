// import 'dart:io';

// import 'package:badges/badges.dart' as badges;
// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:iroots/common/app_data.dart';
// import 'package:iroots/src/controller/dashboard/dashBoard_controller.dart';
// import 'package:iroots/src/ui/comingSoonDummyPage.dart';
// import 'package:iroots/src/ui/dashboard/attendance/admin/admin_attendence.dart';
// import 'package:iroots/src/ui/dashboard/admin/home/admin_home_screen.dart';
// import 'package:iroots/src/ui/dashboard/student/home/student_home_screen.dart';
// import 'package:iroots/src/ui/dashboard/homework/admin/admin_homework.dart';
// import 'package:iroots/src/ui/notification/notification_screen.dart';
// import 'package:iroots/src/utility/const.dart';
// import 'package:iroots/src/utility/util.dart';
// import 'package:new_version_plus/new_version_plus.dart';

// import 'staff/home/staff_home_screen.dart';

// class DashBoardPageScreen extends StatefulWidget {
//   const DashBoardPageScreen({super.key});

//   @override
//   State<DashBoardPageScreen> createState() => _DashBoardPageScreenState();
// }

// class _DashBoardPageScreenState extends State<DashBoardPageScreen> {
//   @override
//   void initState() {
//     if (kReleaseMode) {
//       basicStatusCheck();
//     }

//     super.initState();
//   }

//   basicStatusCheck() async {
//     final remoteConfig = FirebaseRemoteConfig.instance;
//     if (Platform.isIOS
//         ? remoteConfig.getBool("force_update_required_ios")
//         : remoteConfig.getBool("force_update_required")) {
//       final versionForce = Platform.isIOS
//           ? remoteConfig.getString("force_update_ios_version")
//           : remoteConfig.getString("force_update_current_version");
//       final newVersion = NewVersionPlus(
//         forceAppVersion: versionForce,
//         iOSId: appBundle,
//         androidId: appBundle,
//       );
//       final version = await newVersion.getVersionStatus();

//       if (Platform.isAndroid) {
//         if (version?.localVersion != versionForce) {
//           newVersion.showUpdateDialog(
//             context: context,
//             versionStatus: version!,
//             launchModeVersion: LaunchModeVersion.external,
//             allowDismissal: false,
//             dialogText: "Please install now the new version. We made improvements to functionality that will enhance your experience. ",
//             updateButtonText: "Upgrade",
//             dialogTitle: "Please install now the new version. We made improvements to functionality that will enhance your experience. ",
//           );
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//       init: DashBoardController(),
//       builder: (logic) => Scaffold(
//         appBar: AppBar(
//           backgroundColor: ConstClass.themeColor,
//           elevation: 0,
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//           leading: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//             child: GestureDetector(
//               onTap: () {
//                 logic.scaffoldKey.currentState!.openDrawer();
//               },
//               child: SvgPicture.asset(
//                 "assets/icons/topAppBar/side_menu_icon.svg",
//                 height: 34,
//                 width: 34,
//               ),
//             ),
//           ),
//           // title: Image.asset(
//           //   "assets/images/logo.jpeg",
//           //   width: 40.w,
//           //   height: 40.h,
//           // ),
//           actions: [
//             Obx(() {
//               return InkWell(
//                 onTap: () {
//                   if (logic.userRole == "Student") {
//                     Get.to(() => const NotificationScreen());
//                     logic.notificationController.newFetchNotifications();
//                   }
//                 },
//                 child: badges.Badge(
//                   showBadge:
//                       logic.notificationController.notificationCount!.value > 0,
//                   position: badges.BadgePosition.topEnd(top: 0, end: 3),
//                   badgeContent: Text(
//                     logic.notificationController.notificationCount!.value
//                         .toString(),
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   child: Padding(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                     child: SvgPicture.asset(
//                       "assets/icons/topAppBar/noti_icon.svg",
//                       height: 34,
//                       width: 34,
//                     ),
//                   ),
//                 ),
//               );
//             })
//           ],
//         ),
//         key: logic.scaffoldKey,
//         drawer: Drawer(
//           child: logic.userRole == "Administrator"
//               ? SafeArea(
//                   child: ListView(
//                     padding: EdgeInsets.zero,
//                     children: [
//                       buildListTile(
//                         title: "Home",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: logic.selectedIndex == 0
//                               ? FontWeight.w700
//                               : FontWeight.w600,
//                           fontFamily: 'Open Sans',
//                           color: logic.selectedIndex == 0
//                               ? ConstClass.selectedColor
//                               : Colors.black,
//                         ),
//                         imgUrl:
//                             "assets/icons/bottomBar/${logic.selectedIndex == 0 ? "home_select" : "home_unselect"}.svg",
//                         onTap: () {
//                           _onItemTapped(0, logic);
//                           Get.back();
//                         },
//                       ),
//                       buildListTile(
//                         title: "Student Attendence",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: logic.selectedIndex == 1
//                               ? FontWeight.w700
//                               : FontWeight.w600,
//                           fontFamily: 'Open Sans',
//                           color: logic.selectedIndex == 1
//                               ? ConstClass.selectedColor
//                               : Colors.black,
//                         ),
//                         imgUrl:
//                             "assets/icons/bottomBar/${logic.selectedIndex == 1 ? "calendar_select" : "calendar_unselect"}.svg",
//                         onTap: () {
//                           Get.back();
//                           Get.to(() => const AdminAttendanceScreen());
//                         },
//                       ),
//                       buildListTile(
//                         title: "Home Work",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: logic.selectedIndex == 2
//                               ? FontWeight.w700
//                               : FontWeight.w600,
//                           fontFamily: 'Open Sans',
//                           color: logic.selectedIndex == 2
//                               ? ConstClass.selectedColor
//                               : Colors.black,
//                         ),
//                         imgUrl:
//                             "assets/icons/bottomBar/${logic.selectedIndex == 2 ? "message_select" : "message_unselect"}.svg",
//                         onTap: () {
//                           Get.back();
//                           Get.to(() => const AdminHomeworkScreen());
//                         },
//                       ),
//                       buildListTile(
//                         title: "Exam",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: logic.selectedIndex == 3
//                               ? FontWeight.w700
//                               : FontWeight.w600,
//                           fontFamily: 'Open Sans',
//                           color: logic.selectedIndex == 3
//                               ? ConstClass.selectedColor
//                               : Colors.black,
//                         ),
//                         imgUrl:
//                             "assets/icons/bottomBar/${logic.selectedIndex == 3 ? "message_select" : "message_unselect"}.svg",
//                         onTap: () {
//                           Get.back();
//                           // Get.to(() => const AdminFillMarksScreen());
//                         },
//                       ),
//                       buildListTile(
//                         title: "Profile",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: logic.selectedIndex == 4
//                               ? FontWeight.w700
//                               : FontWeight.w600,
//                           fontFamily: 'Open Sans',
//                           color: logic.selectedIndex == 4
//                               ? ConstClass.selectedColor
//                               : Colors.black,
//                         ),
//                         imgUrl:
//                             "assets/icons/bottomBar/${logic.selectedIndex == 4 ? "profile_select" : "profile_unselect"}.svg",
//                         onTap: () {
//                           _onItemTapped(4, logic);
//                           Get.back();
//                         },
//                       ),
//                       buildListTile(
//                         title: "Logout",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           fontFamily: 'Open Sans',
//                           color: Colors.black,
//                         ),
//                         imgUrl: "assets/icons/bottomBar/logout.svg",
//                         onTap: () {
//                           logic.logOut();
//                         },
//                       ),
//                     ],
//                   ),
//                 )
//               : SafeArea(
//                   child: ListView(
//                     padding: EdgeInsets.zero,
//                     children: [
//                       buildListTile(
//                           title: "Home",
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: logic.selectedIndex == 0
//                                 ? FontWeight.w700
//                                 : FontWeight.w600,
//                             fontFamily: 'Open Sans',
//                             color: logic.selectedIndex == 0
//                                 ? ConstClass.selectedColor
//                                 : Colors.black,
//                           ),
//                           imgUrl:
//                               "assets/icons/bottomBar/${logic.selectedIndex == 0 ? "home_select" : "home_unselect"}.svg",
//                           onTap: () {
//                             _onItemTapped(0, logic);
//                             Get.back();
//                           }),
//                       buildListTile(
//                           title: "Calender",
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: logic.selectedIndex == 1
//                                 ? FontWeight.w700
//                                 : FontWeight.w600,
//                             fontFamily: 'Open Sans',
//                             color: logic.selectedIndex == 1
//                                 ? ConstClass.selectedColor
//                                 : Colors.black,
//                           ),
//                           imgUrl:
//                               "assets/icons/bottomBar/${logic.selectedIndex == 1 ? "calendar_select" : "calendar_unselect"}.svg",
//                           onTap: () {
//                             _onItemTapped(1, logic);
//                             Get.back();
//                           }),
//                       buildListTile(
//                           title: "Messages",
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: logic.selectedIndex == 2
//                                 ? FontWeight.w700
//                                 : FontWeight.w600,
//                             fontFamily: 'Open Sans',
//                             color: logic.selectedIndex == 2
//                                 ? ConstClass.selectedColor
//                                 : Colors.black,
//                           ),
//                           imgUrl:
//                               "assets/icons/bottomBar/${logic.selectedIndex == 2 ? "message_select" : "message_unselect"}.svg",
//                           onTap: () {
//                             _onItemTapped(2, logic);
//                             Get.back();
//                           }),
//                       buildListTile(
//                         title: "Profile",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: logic.selectedIndex == 3
//                               ? FontWeight.w700
//                               : FontWeight.w600,
//                           fontFamily: 'Open Sans',
//                           color: logic.selectedIndex == 3
//                               ? ConstClass.selectedColor
//                               : Colors.black,
//                         ),
//                         imgUrl:
//                             "assets/icons/bottomBar/${logic.selectedIndex == 3 ? "profile_select" : "profile_unselect"}.svg",
//                         onTap: () {
//                           _onItemTapped(3, logic);
//                           Get.back();
//                         },
//                       ),
//                       buildListTile(
//                         title: "Logout",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           fontFamily: 'Open Sans',
//                           color: Colors.black,
//                         ),
//                         imgUrl: "assets/icons/bottomBar/logout.svg",
//                         onTap: () {
//                           logic.logOut();
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//         ),
//         body: PageView(
//           physics: const NeverScrollableScrollPhysics(),
//           controller: logic.pageController,
//           onPageChanged: (page) {
//             logic.changePage(page);
//           },
//           children: [
//             logic.userRole == "Student"
//                 ? const StudentHomePageScreen()
//                 : logic.userRole == "Administrator"
//                     ? const AdminHomePageScreen()
//                     : const StaffHomePageScreen(),
//             const ComingSoonDummyPage(),
//             const ComingSoonDummyPage(),
//             const ComingSoonDummyPage(),
//           ],
//         ),
//         bottomNavigationBar: buildBottomBar(logic),
//       ),
//     );
//   }
// }

// ListTile buildListTile(
//     {required String title,
//     required String imgUrl,
//     required TextStyle? style,
//     required void Function()? onTap}) {
//   return ListTile(
//     leading: SvgPicture.asset(
//       imgUrl,
//       width: 20,
//       height: 20,
//     ),
//     title: AppUtil.customText(
//       text: title,
//       style: style,
//     ),
//     onTap: onTap,
//   );
// }

// Widget bottomBarWidget(
//     {required String title,
//     required String imgUrl,
//     required TextStyle? style,
//     required void Function()? onTap}) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//     child: InkWell(
//         onTap: onTap,
//         child: Column(
//           children: [
//             SvgPicture.asset(
//               imgUrl,
//               width: 20,
//               height: 20,
//             ),
//             AppUtil.customText(
//               text: title,
//               style: style,
//             )
//           ],
//         )),
//   );
// }

// Widget buildBottomBar(DashBoardController logic) {
//   return Container(
//     height: 60,
//     color: Colors.white,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         bottomBarWidget(
//             title: "Home",
//             style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: logic.selectedIndex == 0
//                     ? FontWeight.w700
//                     : FontWeight.w600,
//                 fontFamily: 'Open Sans',
//                 color: logic.selectedIndex == 0
//                     ? ConstClass.selectedColor
//                     : ConstClass.unselectedColor),
//             imgUrl:
//                 "assets/icons/bottomBar/${logic.selectedIndex == 0 ? "home_select" : "home_unselect"}.svg",
//             onTap: () {
//               _onItemTapped(0, logic);
//             }),
//         bottomBarWidget(
//             title: "Calender",
//             style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: logic.selectedIndex == 1
//                     ? FontWeight.w700
//                     : FontWeight.w600,
//                 fontFamily: 'Open Sans',
//                 color: logic.selectedIndex == 1
//                     ? ConstClass.selectedColor
//                     : ConstClass.unselectedColor),
//             imgUrl:
//                 "assets/icons/bottomBar/${logic.selectedIndex == 1 ? "calendar_select" : "calendar_unselect"}.svg",
//             onTap: () {
//               _onItemTapped(1, logic);
//             }),
//         bottomBarWidget(
//             title: "Messages",
//             style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: logic.selectedIndex == 2
//                     ? FontWeight.w700
//                     : FontWeight.w600,
//                 fontFamily: 'Open Sans',
//                 color: logic.selectedIndex == 2
//                     ? ConstClass.selectedColor
//                     : ConstClass.unselectedColor),
//             imgUrl:
//                 "assets/icons/bottomBar/${logic.selectedIndex == 2 ? "message_select" : "message_unselect"}.svg",
//             onTap: () {
//               _onItemTapped(2, logic);
//             }),
//         bottomBarWidget(
//             title: "Profile",
//             style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: logic.selectedIndex == 3
//                     ? FontWeight.w700
//                     : FontWeight.w600,
//                 fontFamily: 'Open Sans',
//                 color: logic.selectedIndex == 3
//                     ? ConstClass.selectedColor
//                     : ConstClass.unselectedColor),
//             imgUrl:
//                 "assets/icons/bottomBar/${logic.selectedIndex == 3 ? "profile_select" : "profile_unselect"}.svg",
//             onTap: () {
//               _onItemTapped(3, logic);
//             }),
//       ],
//     ),
//   );
// }

// void _onItemTapped(int index, DashBoardController logic) {
//   logic.changeScreen(index);
// }

import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/controller/dashboard/dashBoard_controller.dart';
import 'package:iroots/src/ui/comingSoonDummyPage.dart';
import 'package:iroots/src/ui/dashboard/attendance/admin/admin_attendence.dart';
import 'package:iroots/src/ui/dashboard/admin/home/admin_home_screen.dart';
import 'package:iroots/src/ui/dashboard/maindashboardscreen.dart';
import 'package:iroots/src/ui/dashboard/student/home/student_home_screen.dart';
import 'package:iroots/src/ui/dashboard/homework/admin/admin_homework.dart';
import 'package:iroots/src/ui/notification/notification_screen.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';
import 'package:new_version_plus/new_version_plus.dart';

import 'staff/home/staff_home_screen.dart';

class DashBoardPageScreen extends StatefulWidget {
  const DashBoardPageScreen({super.key});

  @override
  State<DashBoardPageScreen> createState() => _DashBoardPageScreenState();
}

class _DashBoardPageScreenState extends State<DashBoardPageScreen> {
  @override
  void initState() {
    if (kReleaseMode) {
      basicStatusCheck();
    }

    super.initState();
  }

  Future<void> _refresh() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Simulating network request
    DashBoardController();
  }

  basicStatusCheck() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    if (Platform.isIOS
        ? remoteConfig.getBool("force_update_required_ios")
        : remoteConfig.getBool("force_update_required")) {
      final versionForce = Platform.isIOS
          ? remoteConfig.getString("force_update_ios_version")
          : remoteConfig.getString("force_update_current_version");
      final newVersion = NewVersionPlus(
        forceAppVersion: versionForce,
        iOSId: appBundle,
        androidId: appBundle,
      );
      final version = await newVersion.getVersionStatus();

      if (Platform.isAndroid) {
        if (version?.localVersion != versionForce) {
          newVersion.showUpdateDialog(
            context: context,
            versionStatus: version!,
            launchModeVersion: LaunchModeVersion.external,
            allowDismissal: false,
            dialogText:
                "Please install now the new version. We made improvements to functionality that will enhance your experience. ",
            updateButtonText: "Upgrade",
            dialogTitle:
                "Please install now the new version. We made improvements to functionality that will enhance your experience. ",
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashBoardController(),
      builder: (logic) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: ConstClass.themeColor,
            elevation: 0,
            // centerTitle: true,
            automaticallyImplyLeading: false,
            //  title: InkWell(
            //       child: SizedBox(
            //           height: 80,
            //           width: 120,
            //           child: Image.asset("assets/new/irooticon.png")),
            //       onTap: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) => MainDashBoard()));
            //       },
            //     ),
            // leading: Padding(
            //   padding: const EdgeInsets.only(left: 17.0, right: 0, top: 10),
            //   child: CircleAvatar(
            //     radius: 30,
            //     backgroundColor: Colors.white,
            //     backgroundImage: AssetImage("assets/images/logo.jpeg"),
            //   ),
            // ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 17.0, right: 0, top: 10),
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(appIcon),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10),
                  child: Text(
                    "Welcome",
                    // logic.adminClassDataList.isEmpty
                    //     ? ""
                    //     : logic.adminClassDataList[0].staffName.toString(),

                    // logic.staffDetail.value.name
                    // "Jenny Wilson",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            // leading: Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            //   child: GestureDetector(
            //     onTap: () {
            //       logic.scaffoldKey.currentState!.openDrawer();
            //     },
            //     child: SvgPicture.asset(
            //       "assets/icons/topAppBar/side_menu_icon.svg",
            //       height: 34,
            //       width: 34,
            //     ),
            //   ),
            // ),
            // title: Image.asset(
            //   "assets/images/logo.jpeg",
            //   width: 40.w,
            //   height: 40.h,
            // ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  children: [
                    Obx(() {
                      return InkWell(
                        onTap: () {
                          if (logic.userRole == "Student") {
                            Get.to(() => const NotificationScreen());
                            logic.notificationController
                                .newFetchNotifications();
                          }
                        },
                        child: badges.Badge(
                          showBadge: logic.notificationController
                                  .notificationCount!.value >
                              0,
                          position: badges.BadgePosition.topEnd(top: 0, end: 3),
                          badgeContent: Text(
                            logic
                                .notificationController.notificationCount!.value
                                .toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            child: SvgPicture.asset(
                              "assets/icons/topAppBar/noti_icon.svg",
                              height: 34,
                              width: 34,
                            ),
                          ),
                        ),
                      );
                    }),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      child: GestureDetector(
                        onTap: () {
                          logic.scaffoldKey.currentState!.openDrawer();
                        },
                        child: SvgPicture.asset(
                          "assets/icons/topAppBar/side_menu_icon.svg",
                          height: 34,
                          width: 34,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        key: logic.scaffoldKey,
        drawer: Drawer(
          child: logic.userRole == "Administrator"
              ? SafeArea(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      buildListTile(
                        title: "Home",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: logic.selectedIndex == 0
                              ? FontWeight.w700
                              : FontWeight.w600,
                          fontFamily: 'Open Sans',
                          color: logic.selectedIndex == 0
                              ? ConstClass.selectedColor
                              : Colors.black,
                        ),
                        imgUrl:
                            "assets/icons/bottomBar/${logic.selectedIndex == 0 ? "home_select" : "home_unselect"}.svg",
                        onTap: () {
                          _onItemTapped(0, logic);
                          Get.back();
                        },
                      ),
                      buildListTile(
                        title: "Student Attendence",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: logic.selectedIndex == 1
                              ? FontWeight.w700
                              : FontWeight.w600,
                          fontFamily: 'Open Sans',
                          color: logic.selectedIndex == 1
                              ? ConstClass.selectedColor
                              : Colors.black,
                        ),
                        imgUrl:
                            "assets/icons/bottomBar/${logic.selectedIndex == 1 ? "calendar_select" : "calendar_unselect"}.svg",
                        onTap: () {
                          Get.back();
                          Get.to(() => const AdminAttendanceScreen());
                        },
                      ),
                      buildListTile(
                        title: "Home Work",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: logic.selectedIndex == 2
                              ? FontWeight.w700
                              : FontWeight.w600,
                          fontFamily: 'Open Sans',
                          color: logic.selectedIndex == 2
                              ? ConstClass.selectedColor
                              : Colors.black,
                        ),
                        imgUrl:
                            "assets/icons/bottomBar/${logic.selectedIndex == 2 ? "message_select" : "message_unselect"}.svg",
                        onTap: () {
                          Get.back();
                          Get.to(() => const AdminHomeworkScreen());
                        },
                      ),
                      buildListTile(
                        title: "Exam",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: logic.selectedIndex == 3
                              ? FontWeight.w700
                              : FontWeight.w600,
                          fontFamily: 'Open Sans',
                          color: logic.selectedIndex == 3
                              ? ConstClass.selectedColor
                              : Colors.black,
                        ),
                        imgUrl:
                            "assets/icons/bottomBar/${logic.selectedIndex == 3 ? "message_select" : "message_unselect"}.svg",
                        onTap: () {
                          Get.back();
                          // Get.to(() => const AdminFillMarksScreen());
                        },
                      ),
                      buildListTile(
                        title: "Profile",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: logic.selectedIndex == 4
                              ? FontWeight.w700
                              : FontWeight.w600,
                          fontFamily: 'Open Sans',
                          color: logic.selectedIndex == 4
                              ? ConstClass.selectedColor
                              : Colors.black,
                        ),
                        imgUrl:
                            "assets/icons/bottomBar/${logic.selectedIndex == 4 ? "profile_select" : "profile_unselect"}.svg",
                        onTap: () {
                          _onItemTapped(4, logic);
                          Get.back();
                        },
                      ),
                      buildListTile(
                        title: "Logout",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Open Sans',
                          color: Colors.black,
                        ),
                        imgUrl: "assets/icons/bottomBar/logout.svg",
                        onTap: () {
                          logic.logOut();
                        },
                      ),
                    ],
                  ),
                )
              : SafeArea(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      buildListTile(
                          title: "Home",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: logic.selectedIndex == 0
                                ? FontWeight.w700
                                : FontWeight.w600,
                            fontFamily: 'Open Sans',
                            color: logic.selectedIndex == 0
                                ? ConstClass.selectedColor
                                : Colors.black,
                          ),
                          imgUrl:
                              "assets/icons/bottomBar/${logic.selectedIndex == 0 ? "home_select" : "home_unselect"}.svg",
                          onTap: () {
                            _onItemTapped(0, logic);
                            Get.back();
                          }),
                      buildListTile(
                          title: "Calender",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: logic.selectedIndex == 1
                                ? FontWeight.w700
                                : FontWeight.w600,
                            fontFamily: 'Open Sans',
                            color: logic.selectedIndex == 1
                                ? ConstClass.selectedColor
                                : Colors.black,
                          ),
                          imgUrl:
                              "assets/icons/bottomBar/${logic.selectedIndex == 1 ? "calendar_select" : "calendar_unselect"}.svg",
                          onTap: () {
                            _onItemTapped(1, logic);
                            Get.back();
                          }),
                      buildListTile(
                          title: "Messages",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: logic.selectedIndex == 2
                                ? FontWeight.w700
                                : FontWeight.w600,
                            fontFamily: 'Open Sans',
                            color: logic.selectedIndex == 2
                                ? ConstClass.selectedColor
                                : Colors.black,
                          ),
                          imgUrl:
                              "assets/icons/bottomBar/${logic.selectedIndex == 2 ? "message_select" : "message_unselect"}.svg",
                          onTap: () {
                            _onItemTapped(2, logic);
                            Get.back();
                          }),
                      buildListTile(
                        title: "Profile",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: logic.selectedIndex == 3
                              ? FontWeight.w700
                              : FontWeight.w600,
                          fontFamily: 'Open Sans',
                          color: logic.selectedIndex == 3
                              ? ConstClass.selectedColor
                              : Colors.black,
                        ),
                        imgUrl:
                            "assets/icons/bottomBar/${logic.selectedIndex == 3 ? "profile_select" : "profile_unselect"}.svg",
                        onTap: () {
                          _onItemTapped(3, logic);
                          Get.back();
                        },
                      ),
                      buildListTile(
                        title: "Logout",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Open Sans',
                          color: Colors.black,
                        ),
                        imgUrl: "assets/icons/bottomBar/logout.svg",
                        onTap: () {
                          logic.logOut();
                        },
                      ),
                    ],
                  ),
                ),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: logic.pageController,
          onPageChanged: (page) {
            logic.changePage(page);
          },
          children: [
            logic.userRole == "Student"
                ? const StudentHomePageScreen()
                : logic.userRole == "Administrator"
                    ? const AdminHomePageScreen()
                    : const StaffHomePageScreen(),
            const ComingSoonDummyPage(),
            const ComingSoonDummyPage(),
            const ComingSoonDummyPage(),
          ],
        ),
        bottomNavigationBar: buildBottomBar(logic),
      ),
    );
  }
}

ListTile buildListTile(
    {required String title,
    required String imgUrl,
    required TextStyle? style,
    required void Function()? onTap}) {
  return ListTile(
    leading: SvgPicture.asset(
      imgUrl,
      width: 20,
      height: 20,
    ),
    title: AppUtil.customText(
      text: title,
      style: style,
    ),
    onTap: onTap,
  );
}

Widget bottomBarWidget(
    {required String title,
    required String imgUrl,
    required TextStyle? style,
    required void Function()? onTap}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SvgPicture.asset(
              imgUrl,
              width: 20,
              height: 20,
            ),
            AppUtil.customText(
              text: title,
              style: style,
            )
          ],
        )),
  );
}

Widget buildBottomBar(DashBoardController logic) {
  return Container(
    height: 60,
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        bottomBarWidget(
            title: "Home",
            style: TextStyle(
                fontSize: 12,
                fontWeight: logic.selectedIndex == 0
                    ? FontWeight.w700
                    : FontWeight.w600,
                fontFamily: 'Open Sans',
                color: logic.selectedIndex == 0
                    ? ConstClass.selectedColor
                    : ConstClass.unselectedColor),
            imgUrl:
                "assets/icons/bottomBar/${logic.selectedIndex == 0 ? "home_select" : "home_unselect"}.svg",
            onTap: () {
              _onItemTapped(0, logic);
            }),
        bottomBarWidget(
            title: "Calender",
            style: TextStyle(
                fontSize: 12,
                fontWeight: logic.selectedIndex == 1
                    ? FontWeight.w700
                    : FontWeight.w600,
                fontFamily: 'Open Sans',
                color: logic.selectedIndex == 1
                    ? ConstClass.selectedColor
                    : ConstClass.unselectedColor),
            imgUrl:
                "assets/icons/bottomBar/${logic.selectedIndex == 1 ? "calendar_select" : "calendar_unselect"}.svg",
            onTap: () {
              _onItemTapped(1, logic);
            }),
        bottomBarWidget(
            title: "Messages",
            style: TextStyle(
                fontSize: 12,
                fontWeight: logic.selectedIndex == 2
                    ? FontWeight.w700
                    : FontWeight.w600,
                fontFamily: 'Open Sans',
                color: logic.selectedIndex == 2
                    ? ConstClass.selectedColor
                    : ConstClass.unselectedColor),
            imgUrl:
                "assets/icons/bottomBar/${logic.selectedIndex == 2 ? "message_select" : "message_unselect"}.svg",
            onTap: () {
              _onItemTapped(2, logic);
            }),
        bottomBarWidget(
            title: "Profile",
            style: TextStyle(
                fontSize: 12,
                fontWeight: logic.selectedIndex == 3
                    ? FontWeight.w700
                    : FontWeight.w600,
                fontFamily: 'Open Sans',
                color: logic.selectedIndex == 3
                    ? ConstClass.selectedColor
                    : ConstClass.unselectedColor),
            imgUrl:
                "assets/icons/bottomBar/${logic.selectedIndex == 3 ? "profile_select" : "profile_unselect"}.svg",
            onTap: () {
              _onItemTapped(3, logic);
            }),
      ],
    ),
  );
}

void _onItemTapped(int index, DashBoardController logic) {
  logic.changeScreen(index);
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20); // Start from bottom-left
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height - 20); // Curve at bottom
    path.lineTo(size.width, 0); // Top-right
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
