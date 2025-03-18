// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:encrypt/encrypt.dart' as encryptLib;
// import 'package:webview_flutter/webview_flutter.dart';

// class PaymentScreen extends StatefulWidget {
//   final String? merchentid, secretKey, orderId;
//   final int? txnAmount;
//   const PaymentScreen(
//       {super.key,
//       this.merchentid,
//       this.orderId,
//       this.secretKey,
//       this.txnAmount});

//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   late WebViewController _webViewController;

//   @override
//   void initState() {
//     super.initState();
//     _processPayment();
//   }

//   // Function to Encrypt Data
//   String encryptData(String plainText, String secretKey, String iv) {
//     final key =
//         encryptLib.Key.fromUtf8(secretKey.padRight(32, ' ')); // 32-byte key
//     final ivKey = encryptLib.IV.fromUtf8(iv.padRight(16, ' ')); // 16-byte IV

//     final encrypter =
//         encryptLib.Encrypter(encryptLib.AES(key, mode: encryptLib.AESMode.cbc));
//     final encrypted = encrypter.encrypt(plainText, iv: ivKey);

//     return base64Encode(encrypted.bytes); // Convert to Base64
//   }

//   // Function to Generate Payment URL
//   void _processPayment() async {
//     String merchantId =
//         widget.merchentid.toString(); // Replace with your Merchant ID
//     String secretKey = widget.secretKey.toString(); // Provided by AtomTech
//     String iv = "YOUR_IV"; // Provided by AtomTech

//     // Transaction details
//     String plainText =
//         "merchantId=$merchantId|txnAmount=${widget.txnAmount}|txnCurrency=INR|orderId=${widget.orderId}|returnUrl=https://stpaulapi.lumensof.in/api/Paymet/api/payment/capture-response";

//     // Encrypt the data
//     String encData = encryptData(plainText, secretKey, iv);

//     // Construct the payment URL
//     String paymentUrl =
//         "https://payment1.atomtech.in/ots/aipay/auth?merchId=$merchantId&encData=$encData";

//     print("Generated Payment URL: $paymentUrl");

//     // Load the payment page in WebView
//     _webViewController.loadUrl(paymentUrl);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("AtomTech Payment")),
//       body:

//       WebViewWidget(controller: controller),

//        WebView(
//         initialUrl: "about:blank", // Load the payment URL dynamically
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (controller) {
//           _webViewController = controller;
//         },
//       ),
//     );
//   }
// }
///2
library;

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:encrypt/encrypt.dart' as encryptLib;
// import 'package:webview_flutter/webview_flutter.dart';

// class PaymentScreen extends StatefulWidget {
//   final String? merchantId, secretKey, orderId;
//   final int? txnAmount;

//   const PaymentScreen({
//     super.key,
//     this.merchantId,
//     this.orderId,
//     this.secretKey,
//     this.txnAmount,
//   });

//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   late final WebViewController _webViewController;

//   @override
//   void initState() {
//     super.initState();
//     _webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {},
//           onPageStarted: (String url) {},
//           onPageFinished: (String url) {},
//           onHttpError: (HttpResponseError error) {},
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('http://atom.in?')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       );
//     _processPayment();
//   }

//   String encryptData(String plainText, String secretKey, String iv) {
//     final key = encryptLib.Key.fromUtf8(secretKey.padRight(32, ' '));
//     final ivKey = encryptLib.IV.fromUtf8(iv.padRight(16, ' '));
//     final encrypter =
//         encryptLib.Encrypter(encryptLib.AES(key, mode: encryptLib.AESMode.cbc));
//     final encrypted = encrypter.encrypt(plainText, iv: ivKey);
//     return base64Encode(encrypted.bytes);
//   }

//   void _processPayment() async {
//     String merchantId = widget.merchantId ?? "";
//     String secretKey = widget.secretKey ?? "";
//     String iv = "YOUR_IV";

//     String plainText =
//         "merchantId=$merchantId|txnAmount=${widget.txnAmount}|txnCurrency=INR|orderId=${widget.orderId}|returnUrl=https://stpaulapi.lumensof.in/api/Paymet/api/payment/capture-response";
//     String encData = encryptData(plainText, secretKey, iv);

//     String paymentUrl =
//         "https://payment1.atomtech.in/ots/aipay/mconfig?encData=ngyYl6pRo3VrIYbjQ6eTNaogi603zdtL2Q/6wjYI7nYyFbGZ7TUMfYKow/lLzips3b33XCWJpx5Ec4BCHbZ6AKbtIJIrZK2cERr+BqJxQ88UYnLCOMCq351qMT9EM1ROp2t+ogG8xDoBF+JDRD3kjg==&merchId=628856&info1=36520ba83e52252803b0b4170d16ea61&info2=2263985333a48b417e2e78df9c1d25a3";
//     // "https://payment1.atomtech.in/ots/aipay/auth?merchId=$merchantId&encData=$encData";
//     print("Generated Payment URL: $paymentUrl");

//     _webViewController.loadRequest(Uri.parse(paymentUrl));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("AtomTech Payment")),
//       body: WebViewWidget(controller: _webViewController),
//     );
//   }
// }

////3333333
import 'dart:math';

///3
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encryptLib;
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String? merchantId, secretKey, orderId;
  final num? txnAmount;

  const PaymentScreen({
    super.key,
    this.merchantId,
    this.orderId,
    this.secretKey,
    this.txnAmount,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final WebViewController _webViewController;
  String ivkey = "";

  @override
  void initState() {
    super.initState();

    ivkey = generateIV();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print("WebView loading progress: $progress%");
          },
          onPageStarted: (String url) {
            print("Page started loading: $url");
          },
          onPageFinished: (String url) {
            if (url.contains("success")) {
              Navigator.pop(context, "Payment Successful");
            } else if (url.contains("failure")) {
              Navigator.pop(context, "Payment Failed");
            }
          },
          // onPageFinished: (String url) {

          //   print("Page finished loading: $url");
          // },
          onWebResourceError: (WebResourceError error) {
            print("Web resource error: ${error.description}");
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains("success")) {
              Navigator.pop(context, "Payment Successful");
              return NavigationDecision.prevent;
            } else if (request.url.contains("failure")) {
              Navigator.pop(context, "Payment Failed");
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    _processPayment();
  }

  /// Encrypts payment data using AES encryption
  String encryptData(String plainText, String secretKey, String iv) {
    final key = encryptLib.Key.fromUtf8(secretKey.padRight(32, ' '));
    final ivKey = encryptLib.IV.fromUtf8(iv.padRight(16, ' '));
    final encrypter =
        encryptLib.Encrypter(encryptLib.AES(key, mode: encryptLib.AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: ivKey);
    return base64Encode(encrypted.bytes);
  }

  String generateIV() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(256));
    return base64.encode(values); // Convert to Base64 if needed
  }

  /// Generates the AtomTech payment URL with encrypted data
  void _processPayment() async {
    String merchantId = widget.merchantId ?? "YOUR_MERCHANT_ID";
    String secretKey = widget.secretKey ?? "YOUR_SECRET_KEY";
    String? encrtData = "75AEF0FA1B94B3C10D4F5B268F757F11";
    String iv = ivkey.toString(); // Replace with your IV key
    print("Iv Key");
    print(iv);
    String plainText =
        "merchantId=$merchantId|txnAmount=${widget.txnAmount}|txnCurrency=INR|orderId=${widget.orderId}|returnUrl=https://yourdomain.com/payment-response";
    String encData = encryptData(plainText, secretKey, iv);

    String paymentUrl =
        "https://payment1.atomtech.in/ots/aipay/auth?merchId=$merchantId&encData=$encrtData";

    print("Generated Payment URL: $paymentUrl");

    _webViewController.loadRequest(Uri.parse(paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AtomTech Payment")),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
