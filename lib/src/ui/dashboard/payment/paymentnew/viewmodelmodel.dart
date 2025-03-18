// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewViewModel extends BaseViewModel {
//   WebViewViewModel(this.urll);
//   final String urll;
//   late WebViewController controller;

//   void init(){
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.white)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             setBusy(true);
//             notifyListeners();
//           },
//           onPageStarted: (String url) {
//             setBusy(false);
//             notifyListeners();

//           },
//           onPageFinished: (String url) {
//             setBusy(false);
//             notifyListeners();
//           },
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             // if (request.url.startsWith(urll)) {
//             //   return NavigationDecision.prevent;
//             // }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(urll));

//   }
// }