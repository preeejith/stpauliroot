// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:iroots/bloc/mainbloc.dart';
// import 'package:iroots/src/ui/dashboard/payment/paymentnew/new/paymentauth.dart';
// import 'package:iroots/src/ui/dashboard/payment/paymentnew/paymentcheckoutpage.dart';

// class PaymentSummary extends StatefulWidget {
//   const PaymentSummary({super.key});

//   @override
//   State<PaymentSummary> createState() => _PaymentSummaryState();
// }

// class _PaymentSummaryState extends State<PaymentSummary> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         actions: [],
//         title: Text(
//           "Payment Summary",
//           style: TextStyle(color: Colors.white, fontSize: 16),
//         ),
//       ),
//       body: BlocBuilder<MainBloc, MainState>(
//         builder: (context, state) {
//           return context.read<MainBloc>().preparePaymentRepsonseModel.data ==
//                   null
//               ? CircularProgressIndicator()
//               : Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Row(
//                         children: [
//                           Text("Student Name: "),
//                           Text(context.read<MainBloc>().nameStudent.toString())
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text("Class: "),
//                           Text(context
//                               .read<MainBloc>()
//                               .preparePaymentRepsonseModel
//                               .data!
//                               .classdetails
//                               .toString())
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text("Section: "),
//                           Text(context
//                               .read<MainBloc>()
//                               .preparePaymentRepsonseModel
//                               .data!
//                               .section
//                               .toString())
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text("Category: "),
//                           Text(context
//                               .read<MainBloc>()
//                               .preparePaymentRepsonseModel
//                               .data!
//                               .category
//                               .toString())
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text("Role Number: "),
//                           Text(context
//                               .read<MainBloc>()
//                               .preparePaymentRepsonseModel
//                               .data!
//                               .category
//                               .toString())
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text("Payment Amount: "),
//                           Text(context
//                               .read<MainBloc>()
//                               .totalfeeamount
//                               .toString())
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 24.0),
//                         child: SizedBox(
//                           height: 30,
//                           width: 100,
//                           child: MaterialButton(
//                               color: Colors.red,
//                               onPressed: () {
//                                 int? amount = context
//                                             .read<MainBloc>()
//                                             .preparePaymentRepsonseModel
//                                             .data!
//                                             .amount !=
//                                         null
//                                     ? 0
//                                     : int.parse(context
//                                         .read<MainBloc>()
//                                         .preparePaymentRepsonseModel
//                                         .data!
//                                         .amount
//                                         .toString());
//                                 print("nasjkcba");
//                                 print(context
//                                     .read<MainBloc>()
//                                     .preparePaymentRepsonseModel
//                                     .data!
//                                     .merchId);
//                                 print(context
//                                     .read<MainBloc>()
//                                     .preparePaymentRepsonseModel
//                                     .data!
//                                     .atomTokenId);
//                                 print(context
//                                     .read<MainBloc>()
//                                     .preparePaymentRepsonseModel
//                                     .data!
//                                     .ordedrId);
//                                 print(context
//                                     .read<MainBloc>()
//                                     .preparePaymentRepsonseModel
//                                     .data!
//                                     .amount
//                                     .toString());
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => PaymentPage(
//                                             merchentId: context
//                                                 .read<MainBloc>()
//                                                 .preparePaymentRepsonseModel
//                                                 .data!
//                                                 .merchId)));
//                                 // Navigator.push(
//                                 //     context,
//                                 //     MaterialPageRoute(
//                                 //         builder: (context) => PaymentScreen(
//                                 //             merchantId: context
//                                 //                 .read<MainBloc>()
//                                 //                 .preparePaymentRepsonseModel
//                                 //                 .data!
//                                 //                 .merchId,
//                                 //             secretKey: context
//                                 //                 .read<MainBloc>()
//                                 //                 .preparePaymentRepsonseModel
//                                 //                 .data!
//                                 //                 .atomTokenId,
//                                 //             orderId: context
//                                 //                 .read<MainBloc>()
//                                 //                 .preparePaymentRepsonseModel
//                                 //                 .data!
//                                 //                 .ordedrId,
//                                 //             txnAmount: amount)));
//                               },
//                               child: Text(
//                                 "Check Out",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 12),
//                               )),
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iroots/bloc/mainbloc.dart';
import 'package:iroots/src/ui/dashboard/payment/paymentnew/atompayment/paymentdemom.dart';

class PaymentSummary extends StatefulWidget {
  const PaymentSummary({super.key});

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}

class _PaymentSummaryState extends State<PaymentSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [],
        title: Text(
          "Payment Summary",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return context.read<MainBloc>().preparePaymentRepsonseModel.data ==
                  null
              ? CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Card(
                          color: const Color.fromARGB(255, 192, 225, 242),
                          child: Padding(
                            padding: const EdgeInsets.all(29.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // CircleAvatar(
                                //     child: Padding(
                                //   padding: const EdgeInsets.all(3.0),
                                //   child: Icon(
                                //     Icons.check,
                                //     color: Colors.green,
                                //     size: 29,
                                //   ),
                                // )),
                                CircleAvatar(
                                  radius: 90,
                                  backgroundImage:
                                      AssetImage("assets/new/paymentimg.jpg"),
                                ),

                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Name: ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      context
                                          .read<MainBloc>()
                                          .nameStudent
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Class: ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      context
                                          .read<MainBloc>()
                                          .preparePaymentRepsonseModel
                                          .data!
                                          .classdetails
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Section: ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      context
                                          .read<MainBloc>()
                                          .preparePaymentRepsonseModel
                                          .data!
                                          .section
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Category: ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      context
                                          .read<MainBloc>()
                                          .preparePaymentRepsonseModel
                                          .data!
                                          .category
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Role Number: ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      context
                                          .read<MainBloc>()
                                          .preparePaymentRepsonseModel
                                          .data!
                                          .category
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Payment Amount: ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "₹ ${context.read<MainBloc>().totalfeeamount}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 24.0),
                                  child: SizedBox(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    child: MaterialButton(
                                        color: Colors.blue,
                                        onPressed: () {
                                          String? currentTxnId222 =
                                              'Invoice${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}';
                                          int? amount = context
                                                      .read<MainBloc>()
                                                      .preparePaymentRepsonseModel
                                                      .data!
                                                      .amount !=
                                                  null
                                              ? 0
                                              : int.parse(context
                                                  .read<MainBloc>()
                                                  .preparePaymentRepsonseModel
                                                  .data!
                                                  .amount
                                                  .toString());
                                          print("nasjkcba");
                                          print(context
                                              .read<MainBloc>()
                                              .preparePaymentRepsonseModel
                                              .data!
                                              .merchId);
                                          print(context
                                              .read<MainBloc>()
                                              .preparePaymentRepsonseModel
                                              .data!
                                              .atomTokenId);
                                          print(context
                                              .read<MainBloc>()
                                              .preparePaymentRepsonseModel
                                              .data!
                                              .ordedrId);
                                          print(context
                                              .read<MainBloc>()
                                              .preparePaymentRepsonseModel
                                              .data!
                                              .amount
                                              .toString());

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PayPage()));

                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             PaymentWebView(
                                          //               atomTokenId:
                                          //                   // "15000023362963",
                                          //                   context
                                          //                       .read<
                                          //                           MainBloc>()
                                          //                       .preparePaymentRepsonseModel
                                          //                       .data!
                                          //                       .atomTokenId
                                          //                       .toString(),
                                          //               merchId: context
                                          //                   .read<MainBloc>()
                                          //                   .preparePaymentRepsonseModel
                                          //                   .data!
                                          //                   .merchId
                                          //                   .toString(),
                                          //               custmobile: context
                                          //                   .read<MainBloc>()
                                          //                   .preparePaymentRepsonseModel
                                          //                   .data!
                                          //                   .custMobile
                                          //                   .toString(),
                                          //               custemail: context
                                          //                   .read<MainBloc>()
                                          //                   .preparePaymentRepsonseModel
                                          //                   .data!
                                          //                   .custEmail
                                          //                   .toString(),
                                          //               returnurl: context
                                          //                   .read<MainBloc>()
                                          //                   .preparePaymentRepsonseModel
                                          //                   .data!
                                          //                   .returnurl
                                          //                   .toString(),
                                          //               // "https://stpaulapi.lumensof.in/api/Paymet/api/payment/capture-response",
                                          //               // context
                                          //               //     .read<MainBloc>()
                                          //               //     .preparePaymentRepsonseModel
                                          //               //     .data!
                                          //               //     .returnurl
                                          //               //     .toString(),
                                          //               // "656207",

                                          //               // merchId,
                                          //               currentTxnId:
                                          //                   currentTxnId222,
                                          //             )));

                                          //  Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) => PaymentPage(
                                          //             merchentId: context
                                          //                 .read<MainBloc>()
                                          //                 .preparePaymentRepsonseModel
                                          //                 .data!
                                          //                 .merchId)));
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) => PaymentScreen(
                                          //             merchantId: context
                                          //                 .read<MainBloc>()
                                          //                 .preparePaymentRepsonseModel
                                          //                 .data!
                                          //                 .merchId,
                                          //             secretKey: context
                                          //                 .read<MainBloc>()
                                          //                 .preparePaymentRepsonseModel
                                          //                 .data!
                                          //                 .atomTokenId,
                                          //             orderId: context
                                          //                 .read<MainBloc>()
                                          //                 .preparePaymentRepsonseModel
                                          //                 .data!
                                          //                 .ordedrId,
                                          //             txnAmount: amount)));
                                        },
                                        child: Text(
                                          "Check Out",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
