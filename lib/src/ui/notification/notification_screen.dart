import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iroots/src/controller/notification/new_notification_controller.dart';
import 'package:iroots/src/modal/notification/notification_modal_class.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: NewNotificationController(),
        builder: (logic) => Scaffold(
              appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: ConstClass.dashBoardColor,
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 8),
                      child: IconButton(
                          icon: const Icon(Icons.arrow_back_outlined),
                          iconSize: 25,
                          onPressed: () {
                            logic.fetchNotifications();
                            Get.back();
                          }),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    AppUtil.customText(
                      text: "Notification",
                      style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Obx(() {
                    if (logic.notificationProgress.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (logic.isDataFound.value) {
                      return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: logic.notificationList!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                logic.clickNotification(
                                    logic.notificationList![index]);
                              },
                              child: buildHomeworkWidget(
                                  logic.notificationList![index]));
                        },
                      );
                    } else {
                      return AppUtil.noDataFound("No Data Found");
                    }
                  })),
            ));
  }

  Widget buildHomeworkWidget(NotificationDatum notificationDatum) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppUtil.customText(
              text: notificationDatum.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            ),
            const SizedBox(
              height: 5,
            ),
            AppUtil.customText(
              text: notificationDatum.body,
              style: TextStyle(
                  color: ConstClass.themeColor,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
