import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iroots/src/controller/home/staff/academics_home_controller.dart';
import 'package:iroots/src/modal/dashboardModalClass.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

class AcademicsFullScreen extends StatelessWidget {
  const AcademicsFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AcademicsController(),
      builder: (logic) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ConstClass.dashBoardColor,
            title: AppUtil.customText(
              text: "Academics",
              style: const TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
          ),
          body:
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: logic.staffAcademicList.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      logic.onItemTapped(index);
                    },
                    child: buildAcademicWidget(
                        logic.staffAcademicList[index]));
              },
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 5 / 5,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
            ),
          )),
    );
  }
}



Widget buildAcademicWidget(DashBoardModal academicList) {
  return Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            academicList.image!,
            width: 22,
            height: 22,
          ),
          const SizedBox(
            height: 5,
          ),
          AppUtil.customText(
            text: academicList.title!,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color(0xff334155),
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                fontSize: 12),
          )
        ],
      ),
    ),
  );
}

