import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
// pk_test_51NEyyFCLicb7WxzzXr1nPmEUKNiMxfbv9jxDIAA8bKAt5JNyC99H9LuWKv8QCP1Rhz3LGm3J0KoTtauIlWxumwbA00NVbsdhKA
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
// void initiatePayment() {
//   StripePayment.paymentRequestWithCardForm(
//     CardFormPaymentRequest(),
//   ).then((paymentMethod) {
//     // Use the paymentMethod for further processing
//     // E.g., send paymentMethod.id to your server for charging the card
//   }).catchError((error) {
//     // Handle payment errors
//     print('Error: ${error.toString()}');
//   });
// }

  @override
  Widget build(BuildContext context) {
    return Center(child: ElevatedButton(child: Text('payy'),onPressed:(){}
    //  initiatePayment,
     ),);
  }
}