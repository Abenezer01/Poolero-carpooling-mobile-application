import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;

  Future<bool> makePayment(
      {required String amount, required String currency}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      print('makePayment');
      print(paymentIntentData);

      if (paymentIntentData != null) {
        print('displayPaymentSheet-0');
        return await Stripe.instance
            .initPaymentSheet(
                paymentSheetParameters: SetupPaymentSheetParameters(
          // applePay: true,
          // googlePay: true,
          // testEnv: true,
          // merchantCountryCode: 'US',
          merchantDisplayName: 'Prospects',
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ))
            .then((value) {
          print('displayPaymentSheet-1');
          return displayPaymentSheet();
        });
      }

      return false;
    } catch (e, s) {
      print('exception:$e$s');
      rethrow;
    }
  }

  Future<bool> displayPaymentSheet() async {
    try {
      print('displayPaymentSheet-2');
      await Stripe.instance.presentPaymentSheet();
      print('displayPaymentSheet-3');
      Get.snackbar(
        'Payment',
        'Payment Successful',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      );
      return true;
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
      return false;
    } catch (e) {
      print("exception:$e");
      return false;
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51LiINJCMHlLurkUjbdk9XkHmSH6vIkwQuB5FyBo5ATGf20KB6vP06q3bX7TiHYcinrAg2KoRdYC1rFmm09WVngCD00DuuWXxWl',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
