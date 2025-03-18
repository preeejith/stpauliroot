import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iroots/src/ui/dashboard/payment/paymentnew/new/paymentservice.dart';

class PaymentPage extends StatefulWidget {
  final String? merchentId;

  const PaymentPage({super.key, this.merchentId});
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final PaymentService paymentService = PaymentService();
  final TextEditingController encDataController = TextEditingController();

  @override
  void initState() {
    super.initState();
    paymentService.storeKeys();
  }

  Future<void> authenticate() async {
    final encData = encDataController.text;
    await paymentService.authenticateUser(
        encData, widget.merchentId.toString());
  }

  Future<void> makePayment() async {
    final paymentDetails = jsonEncode({
      'amount': '100.00',
      'currency': 'INR',
      'description': 'Test Payment',
    });
    await paymentService.processPayment(paymentDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atom Payment Gateway'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: encDataController,
              decoration: InputDecoration(labelText: 'Enc Data'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: authenticate,
              child: Text('Authenticate'),
            ),
            ElevatedButton(
              onPressed: makePayment,
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
