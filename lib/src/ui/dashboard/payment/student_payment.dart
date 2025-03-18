import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iroots/src/controller/payment/student/payment_controller.dart';
import 'package:iroots/src/ui/dashboard/payment/paymentnew/paymentsummary.dart';
import 'package:iroots/src/ui/dashboard/payment/student_payment_method.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

import '../../../../bloc/mainbloc.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    BlocProvider.of<MainBloc>(context).add(GetStudentFeeList());
    BlocProvider.of<MainBloc>(context).add(GetStudentTotalamount());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: PaymentController(),
        builder: (logic) => Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: ConstClass.dashBoardColor,
                title: AppUtil.customText(
                    text: " Fees Details ",
                    style: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 16)),
                // bottom: PreferredSize(
                //   preferredSize: const Size.fromHeight(60),
                //   child: Container(
                //     color: Colors.white,
                //     child: TabBar(
                //       labelColor: ConstClass.selectedColor,
                //       unselectedLabelColor: Colors.grey,
                //       controller: logic.tabController,
                //       labelStyle: TextStyle(
                //           color: ConstClass.selectedColor,
                //           fontFamily: 'Open Sans',
                //           fontWeight: FontWeight.bold,
                //           fontSize: 12),
                //       // unselectedLabelStyle: const TextStyle(
                //       //     color: Colors.grey,
                //       //     fontFamily: 'Open Sans',
                //       //     fontWeight: FontWeight.bold,
                //       //     fontSize: 12),
                //       tabs: const [
                //         Tab(text: 'Term Fees'),
                //         // Tab(text: 'Transport Fees'),
                //       ],
                //     ),
                //   ),
                // ),
              ),
              body: tabWidget(),
              // TabBarView(
              //   physics: const NeverScrollableScrollPhysics(),
              //   controller: logic.tabController,
              //   children: [
              //     tabWidget(),
              //     // tabWidget(),
              //   ],
              // ),
              bottomNavigationBar: BlocConsumer<MainBloc, MainState>(
                builder: (context, state) {
                  return Container(
                    color: const Color(0xffF1F5F9),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
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
                                    horizontal: 5, vertical: 7),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: state is GettingReadyPaymentLoading
                                      ? CircularProgressIndicator()
                                      : AppUtil.customText(
                                          text: "Payment",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Open Sans',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14),
                                        ),
                                )), () {
                          BlocProvider.of<MainBloc>(context)
                              .add(GetPreparePayment());

                          // Get.to(() => const PaymentMethodScreen());
                        }),
                      ),
                    ),
                  );
                },
                listener: (context, state) {
                  if (state is PaymentInputResSuccess) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentSummary()));
                    // Get.to(() => const PaymentMethodScreen());
                  }
                },
              ),
            ));
  }

  Widget tabWidget() {
    bool isChecked = false;
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return context.read<MainBloc>().studentFeeListModel.feeDetails == null
            ? SizedBox.shrink()
            : context.read<MainBloc>().studentFeeListModel.feeDetails!.isEmpty
                ? SizedBox.shrink()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        // AppUtil.customText(
                        //   text: "Fees Details",
                        //   style: const TextStyle(
                        //       fontFamily: 'Open Sans',
                        //       fontWeight: FontWeight.w700,
                        //       fontSize: 14),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16, top: 16),
                          child: Column(
                            children: List.generate(
                                context
                                    .read<MainBloc>()
                                    .studentFeeListModel
                                    .feeDetails!
                                    .length, (index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 169, 200, 225),
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 0.9,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        // IconButton(
                                                        //   onPressed: () {},
                                                        //   icon: const Icon(
                                                        //       Icons.check_box),
                                                        //   color:
                                                        //       ConstClass.themeColor,
                                                        // ),

                                                        Checkbox(
                                                          activeColor:
                                                              Colors.blue,
                                                          checkColor:
                                                              Colors.white,
                                                          value: context
                                                              .read<MainBloc>()
                                                              .studentFeeListModel
                                                              .feeDetails![
                                                                  index]
                                                              .checkboxvalue,
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              context
                                                                  .read<
                                                                      MainBloc>()
                                                                  .studentFeeListModel
                                                                  .feeDetails![
                                                                      index]
                                                                  .checkboxvalue = value!;
                                                            });

                                                            BlocProvider.of<
                                                                        MainBloc>(
                                                                    context)
                                                                .add(
                                                                    GetStudentTotalamount());
                                                          },
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                context
                                                                    .read<
                                                                        MainBloc>()
                                                                    .studentFeeListModel
                                                                    .feeDetails![
                                                                        index]
                                                                    .feeName
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'Open Sans',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        12),
                                                              )
                                                              // AppUtil.customText(
                                                              //   text: "First Term",
                                                              //   style: const TextStyle(
                                                              //       fontFamily: 'Open Sans',
                                                              //       fontWeight: FontWeight.w600,
                                                              //       fontSize: 12),
                                                              // ),
                                                              // AppUtil.customText(
                                                              //   text: "Last Due date :- 30-Apr-2024",
                                                              //   style: const TextStyle(
                                                              //       color: Color(0xffE11D48),
                                                              //       fontFamily: 'Open Sans',
                                                              //       fontWeight: FontWeight.w500,
                                                              //       fontSize: 10),
                                                              // ),
                                                              // AppUtil.customText(
                                                              //   text: "Due date :- 20-Apr-2024",
                                                              //   style: const TextStyle(
                                                              //       color: Colors.grey,
                                                              //       fontFamily: 'Open Sans',
                                                              //       fontWeight: FontWeight.w500,
                                                              //       fontSize: 10),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),

                                                        // AppUtil.customText(
                                                        //   text: "₹2000",
                                                        //   style: const TextStyle(
                                                        //       color: Color(0xff1575FF),
                                                        //       fontFamily: 'Open Sans',
                                                        //       fontWeight:
                                                        //           FontWeight.w700,
                                                        //       fontSize: 10),
                                                        // ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: .1,
                                                        child: Divider(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              177, 167, 167),
                                                        )),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 38.0,
                                                              top: 5),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Text(
                                                                "Total ",
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xff1575FF),
                                                                    fontFamily:
                                                                        'Open Sans',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(
                                                                "₹ ${context.read<MainBloc>().studentFeeListModel.feeDetails![index].feeValue}",
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xff1575FF),
                                                                    fontFamily:
                                                                        'Open Sans',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ],
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            child: Container(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    221,
                                                                    155,
                                                                    149),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5.0),
                                                                  child: Text(
                                                                    "Pending",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            240,
                                                                            45,
                                                                            31)),
                                                                  ),
                                                                )),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0, right: 18),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xff034BB1),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppUtil.customText(
                                      text: "Total Due Amount",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                    AppUtil.customText(
                                      text:
                                          "₹${context.read<MainBloc>().studentFeeListModel.totalAmount!}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 18.0, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppUtil.customText(
                                        text: "Paying Amount",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Open Sans',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                      AppUtil.customText(
                                        text:
                                            "₹${context.read<MainBloc>().totalfeeamount}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Open Sans',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
      },
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
                // AppUtil.customText(
                //   text: "Last Due date :- 30-Apr-2024",
                //   style: const TextStyle(
                //       color: Color(0xffE11D48),
                //       fontFamily: 'Open Sans',
                //       fontWeight: FontWeight.w500,
                //       fontSize: 10),
                // ),
                // AppUtil.customText(
                //   text: "Due date :- 20-Apr-2024",
                //   style: const TextStyle(
                //       color: Colors.grey,
                //       fontFamily: 'Open Sans',
                //       fontWeight: FontWeight.w500,
                //       fontSize: 10),
                // ),
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
      /* onPressed: () {
        logic.pickDateDialog(context);
      },*/
      onPressed: onPressed,
      child: widget,
    );
  }
}
