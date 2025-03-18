import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iroots/src/controller/payment/student/payment_method_controller.dart';
import 'package:iroots/src/ui/dashboard/payment/student_payment_confirm.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

enum PaymentRadio { phonepe, googlePay, upi }

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: PaymentMethodController(),
        builder: (logic) => DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: ConstClass.dashBoardColor,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppUtil.customText(
                        text: "Step 2 of 2",
                        style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 10)),
                    AppUtil.customText(
                        text: "Payment Method",
                        style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 14)),
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(95),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppUtil.customText(
                                  text: "Amount Payable",
                                  style: const TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14)),
                              AppUtil.customText(
                                  text: "₹4000",
                                  style: const TextStyle(
                                      color: Color(0xff1575FF),
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14)),
                            ],
                          ),
                        ),
                        TabBar(
                          labelColor: ConstClass.selectedColor,
                          unselectedLabelColor: Colors.grey,
                          controller: logic.tabController,
                          indicatorColor: Colors.transparent,
                          labelStyle: TextStyle(
                              color: ConstClass.selectedColor,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 10),
                          unselectedLabelStyle: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 10),
                          tabs: [
                            tabWidget("Credit/Debit Card",
                                "assets/icons/payment/icon_credit_card.svg"),
                            tabWidget("Bank Transfer",
                                "assets/icons/payment/icon_bank.svg"),
                            tabWidget("UPI",
                                "assets/icons/payment/icon_credit_card.svg"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: logic.tabController,
                children: [
                  tabBarWidgetOne(logic),
                  tabBarWidgetTwo(logic),
                  tabBarWidgetThree(logic),
                ],
              ),
              bottomNavigationBar: Container(
                color: const Color(0xffF1F5F9),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: SizedBox(
                    width: Get.width,
                    child: customOutlinedButton(
                        OutlinedButton.styleFrom(
                          backgroundColor: ConstClass.themeColor,
                          side: BorderSide(
                              width: 1.5, color: ConstClass.themeColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 12),
                            child: AppUtil.customText(
                              text: "Pay Now",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            )),
                        () {

                          Get.to(() => const PaymentConfirmationScreen());

                        }),
                  ),
                ),
              ),
            )));
  }

  Widget tabBarWidgetOne(PaymentMethodController logic) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppUtil.customText(
            text: "Card Details",
            style: const TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700,
                fontSize: 12),
          ),
          const SizedBox(
            height: 10,
          ),
          widgetTextField(
              prefixIcon: const Icon(Icons.email),
              controllerEmail: logic.controllerCarHolderName,
              hint: "Enter card holder name",
              maxLength: 50,
              keyboardType: TextInputType.emailAddress),
          const SizedBox(
            height: 10,
          ),
          widgetTextField(
              prefixIcon: const Icon(Icons.email),
              controllerEmail: logic.controllerCarHolderName,
              hint: "Card Number",
              maxLength: 12,
              keyboardType: TextInputType.number),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  width: 0.5,
                  child: widgetTextField(
                      prefixIcon: const Icon(Icons.email),
                      controllerEmail: logic.controllerCarHolderName,
                      hint: "Expiry Date",
                      maxLength: 50,
                      keyboardType: TextInputType.emailAddress),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: SizedBox(
                  width: 0.25,
                  child: widgetTextField(
                      prefixIcon: const Icon(Icons.email),
                      controllerEmail: logic.controllerCarHolderName,
                      hint: "CVV",
                      maxLength: 3,
                      keyboardType: TextInputType.number),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget feesTermWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check_box),
            color: ConstClass.themeColor,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppUtil.customText(
                  text: "First Term",
                  style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
                AppUtil.customText(
                  text: "Last Due date :- 30-Apr-2024",
                  style: const TextStyle(
                      color: Color(0xffE11D48),
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w500,
                      fontSize: 10),
                ),
                AppUtil.customText(
                  text: "Due date :- 20-Apr-2024",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w500,
                      fontSize: 10),
                ),
              ],
            ),
          ),
          AppUtil.customText(
            text: "₹2000",
            style: const TextStyle(
                color: Color(0xff1575FF),
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700,
                fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget customOutlinedButton(
      ButtonStyle buttonStyle, Widget widget, Function() onPressed) {
    return OutlinedButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: widget,
    );
  }

  Widget tabWidget(String title, String icon) {
    return Tab(
      text: title,
      icon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(
            color: Colors.grey,
            width: 0.9,
          ),
        ),
        child: SvgPicture.asset(
          icon,
          width: 15,
          height: 15,
        ),
      ),
    );
  }

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
          borderSide: const BorderSide(
            color: Color(0xff94A3B8),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff94A3B8),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      style: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      maxLength: maxLength,
    );
  }

  static Widget widgetTextField1(
      {required TextEditingController controllerEmail,
      required String hint,
      required TextInputType? keyboardType,
      required int maxLength,
      bool? isPassword}) {
    return TextFormField(
      obscureText: isPassword ?? false,
      controller: controllerEmail,
      decoration: InputDecoration(
        hintText: hint,
        counterText: '',
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        fillColor: Colors.white,
        filled: true,
        hintStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff94A3B8),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff94A3B8),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      style: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      maxLength: maxLength,
    );
  }

  Widget tabBarWidgetTwo(PaymentMethodController logic) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppUtil.customText(
              text: "Transfer Mode",
              style: const TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                transferModeTextWidget("NEFT", ConstClass.selectedColor),
                const SizedBox(
                  width: 20,
                ),
                transferModeTextWidget("RTGS", Colors.grey),
                const SizedBox(
                  width: 20,
                ),
                transferModeTextWidget("IMPS", Colors.grey),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            AppUtil.customText(
              text: "Note : NEFT transfer money within 1 Hour",
              style: const TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 10,
            ),
            AppUtil.customText(
              text: "Account Number",
              style: const TextStyle(
                  color: Color(0xff475569),
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 5,
            ),
            widgetTextField1(
                controllerEmail: logic.controllerCarHolderName,
                hint: "Enter account number",
                maxLength: 50,
                keyboardType: TextInputType.emailAddress),
            const SizedBox(
              height: 10,
            ),
            AppUtil.customText(
              text: "Name",
              style: const TextStyle(
                  color: Color(0xff475569),
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 5,
            ),
            widgetTextField1(
                controllerEmail: logic.controllerCarHolderName,
                hint: "Enter name",
                maxLength: 50,
                keyboardType: TextInputType.emailAddress),
            const SizedBox(
              height: 10,
            ),
            AppUtil.customText(
              text: "Branch Name",
              style: const TextStyle(
                  color: Color(0xff475569),
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 5,
            ),
            widgetTextField1(
                controllerEmail: logic.controllerCarHolderName,
                hint: "Enter branch name",
                maxLength: 50,
                keyboardType: TextInputType.emailAddress),
            const SizedBox(
              height: 10,
            ),
            AppUtil.customText(
              text: "Remarks (Optional)",
              style: const TextStyle(
                  color: Color(0xff475569),
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 5,
            ),
            widgetTextField1(
                controllerEmail: logic.controllerCarHolderName,
                hint: "Enter remarks",
                maxLength: 50,
                keyboardType: TextInputType.emailAddress),
            const SizedBox(
              height: 10,
            ),
            AppUtil.customText(
              text: "Amount",
              style: const TextStyle(
                  color: Color(0xff475569),
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 5,
            ),
            widgetTextField1(
                controllerEmail: logic.controllerCarHolderName,
                hint: "Enter amount",
                maxLength: 50,
                keyboardType: TextInputType.emailAddress),
          ],
        ),
      ),
    );
  }

  Widget transferModeTextWidget(String title, Color selectedColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(
          color: selectedColor,
          width: 1,
        ),
      ),
      child: AppUtil.customText(
        text: title,
        style: const TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w700,
            fontSize: 10),
      ),
    );
  }

  Widget tabBarWidgetThree(PaymentMethodController logic) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppUtil.customText(
            text: "UPI Transfer",
            style: const TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700,
                fontSize: 12),
          ),
          Container(
            width: Get.width,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                color: Colors.grey,
                width: 0.9,
              ),
            ),
            child: Column(
              children: [
                radioWidget("assets/icons/payment/img_phonepe.png", "Phone Pe",
                    PaymentRadio.phonepe, (newValue) {

                }),
                radioWidget("assets/icons/payment/img_google_pay.png", "Google Pay",
                    PaymentRadio.googlePay, (newValue) {

                    }),
                radioWidget("assets/icons/payment/img_upi.png", "UPI ID",
                    PaymentRadio.googlePay, (newValue) {

                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget radioWidget(String radioIcon, String radioTitle,
      PaymentRadio currentRadio, Null Function(dynamic newValue) radioChanged) {
    return ListTile(

      title: Row(
        children: [
          Image.asset(
            radioIcon,
            width: 20,
            height: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          AppUtil.customText(
            text: radioTitle,
            style: const TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700,
                fontSize: 12),
          ),
        ],
      ),
      leading: Radio(
        value: PaymentRadio.phonepe,
        groupValue: currentRadio,
        onChanged: radioChanged,
      ),
    );
  }
}
