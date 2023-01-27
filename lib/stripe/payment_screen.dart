import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  var secret =
      "sk_test_51MUQTeG8f4YHCKc16bHB3fUHcEFVXKPwKRg71JejeCqlsUqZokXUU47vwFHbLgCUAiBqD7O9X35umbs9AbNmA4Ns00XYW9w7K1";
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
              // makePayment();
              createcustomer();
            },
            child: isLoading
                ? const CupertinoActivityIndicator(
                    color: Colors.white,
                  )
                : const Text("make it"),
          ),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
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

  Future<void> createcustomer() async {
    setState(() {
      isLoading = true;
    });
    try {
      var body = {
        'name': 'Jenny Rosen',
        'address': {
          'line1': '510 Townsend St',
          'postal_code': '98140',
          'city': 'San Francisco',
          'state': 'CA',
          'country': 'US',
        }
      };
      http.Response response = await http.post(
        Uri.parse('https://api.stripe.com/v1/customers'),
        body: body,
        //  options: Options(contentType:Headers.formUrlEncodedContentType,
        headers: {
          'Authorization': 'Bearer $secret',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );
      var data = jsonDecode(response.body);

      print(data);
      setState(() {
        isLoading = false;
      });
      // return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }
}

// StripePayment.setOptions(StripeOptions(
//     publishableKey:"public live key",
//          merchantId: 'merchant.thegreatestmarkeplace', //merchantId
//          androidPayMode: 'production'));
