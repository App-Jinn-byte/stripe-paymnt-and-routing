import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Map<String, dynamic>? paymentIntent;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Stripe Payment"),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              makePayment();
            },
            child: Text(isLoading ? "wait..." : "make it"),
          ),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    var secret =
        "sk_test_51MUQTeG8f4YHCKc16bHB3fUHcEFVXKPwKRg71JejeCqlsUqZokXUU47vwFHbLgCUAiBqD7O9X35umbs9AbNmA4Ns00XYW9w7K1";
    try {
      const url = 'https://api.stripe.com/v1/payment_intents';
      Map<String, dynamic> body = {
        "amount": "1000",
        "currency": "USD",
      };

      http.Response response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          'Authorization': 'Bearer $secret',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );
      paymentIntent = jsonDecode(response.body);
    } catch (e) {
      print("error : $e");
    }
    await Stripe.instance
        .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            style: ThemeMode.light,
            merchantDisplayName: 'WsSkool',
          ),
        )
        .then((value) {});
    // var paymentMethod = await Stripe.instance
    //     .retrievePaymentIntent(paymentIntent!['client_secret']);

    // print("object Object $paymentMethod");

    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        // Stripe.instance.createToken();
        print("Payment Success");
      });
    } catch (e) {
      print("error: $e");
    }
  }
}

// StripePayment.setOptions(StripeOptions(
//     publishableKey:"public live key",
//          merchantId: 'merchant.thegreatestmarkeplace', //merchantId
//          androidPayMode: 'production'));
