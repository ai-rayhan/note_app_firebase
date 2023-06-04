import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

// pk_test_51NEyyFCLicb7WxzzXr1nPmEUKNiMxfbv9jxDIAA8bKAt5JNyC99H9LuWKv8QCP1Rhz3LGm3J0KoTtauIlWxumwbA00NVbsdhKA
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Map<String, dynamic>? paymentIntend;
  makepayment() async {
    try {
      paymentIntend = await createPayment();
      var gpay = PaymentSheetGooglePay(
          merchantCountryCode: "US", currencyCode: 'US', testEnv: true);
      Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntend!['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: "sabir",
              googlePay: gpay));
    } catch (e) {}
  }

  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("done");
    } catch (e) {
      print(e);
    }
  }

  createPayment() async {
    try {
      Map<String, dynamic> body = {
        "amount": "100",
        "currency": "US",
      };
      http.Response response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
                "sk_test_51MWx8OAVMyklfe3C3gP4wKOhTsRdF6r1PYhhg1PqupXDITMrV3asj5Mmf0G5F9moPL6zNfG3juK8KHgV9XNzFPlq00wmjWwZYA",
            "Content_Type": "application/x-www-form-urlencoded"
          });
      return json.decode(response.body);
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          child: Text('payy'),
          onPressed: () {
            makepayment();
          }
          //  initiatePayment,
          ),
    );
  }
}
