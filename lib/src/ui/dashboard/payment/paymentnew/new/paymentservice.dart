import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentService {
  final String authUrl =
      'https://caller.atomtech.in/ots/aipay/auth?merchId={0}&encData={1}';
  final String merchId = '317159';
  final String encryptionKey = 'A4476C2062FFA58980DC8F79EB6A799E';
  final String decryptionKey = '75AEF0FA1B94B3C10D4F5B268F757F11';
  final String resultUrl = 'http://atom.in';

  final storage = FlutterSecureStorage();

  Future<void> authenticateUser(String encData, String merchentId) async {
    final url =
        authUrl.replaceFirst('{0}', merchId).replaceFirst('{1}', encData);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Handle successful authentication
      print('Authentication successful');
    } else {
      // Handle authentication error
      print('Authentication failed: ${response.statusCode}');
    }
  }

  Future<void> processPayment(String paymentDetails) async {
    final url = 'https://caller.atomtech.in/ots/aipay/process';
    final response = await http.post(Uri.parse(url), body: paymentDetails);

    if (response.statusCode == 200) {
      // Handle successful payment
      print('Payment successful');
    } else {
      // Handle payment error
      print('Payment failed: ${response.statusCode}');
    }
  }

  Future<void> storeKeys() async {
    await storage.write(key: 'encryptionKey', value: encryptionKey);
    await storage.write(key: 'decryptionKey', value: decryptionKey);
  }

  Future<void> retrieveKeys() async {
    final encryptionKey = await storage.read(key: 'encryptionKey');
    final decryptionKey = await storage.read(key: 'decryptionKey');
    // Use the keys as needed
  }
}
