import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:convert';

import '../controller/buy_course_controller.dart';

class BuyCourse extends ConsumerStatefulWidget {
  const BuyCourse({Key? key}) : super(key: key);

  @override
  ConsumerState<BuyCourse> createState() => _BuyCourseState();
}

class _BuyCourseState extends ConsumerState<BuyCourse> {
  late var args;
  late Razorpay _razorpay;
  bool _paymentInitiated = false;
  String? courseId;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map && args.containsKey("id")) {
        setState(() {
          courseId = args["id"].toString();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          content: const Text('Your payment has been completed successfully.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Pop the BuyCourse screen
              },
            ),
          ],
        );
      },
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Failed'),
          content: Text('Error: ${response.message ?? "Unknown error"}'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Return to the previous screen
              },
            ),
          ],
        );
      },
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('External wallet selected: ${response.walletName}')),
    );
  }

  void initiatePayment(Map<String, dynamic> options) {
    if (!_paymentInitiated) {
      setState(() {
        _paymentInitiated = true;
      });
      openCheckout(options);
    }
  }

  void openCheckout(Map<String, dynamic> options) {
    var opts = {
      'key': options['razorpay_key'],
      'amount': options['amount'],
      'name': options['course_name'],
      'order_id': options['order_id'],
      'description': 'Course Purchase',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    print('Razorpay options:');
    opts.forEach((key, value) {
      print('$key: $value');
    });

    try {
      _razorpay.open(opts);
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
        _paymentInitiated = false;
      });
    }
  }

//   @override
//   Widget build(BuildContext context) {
//     if (courseId == null) {
//       return const Scaffold(
//         body: Center(child: Text("Loading course information...")),
//       );
//     }
//     var courseBuyData =
//         ref.watch(buyCourseControllerProvider(index: args.toInt()));
//
//     return Scaffold(
//       body: courseBuyData.when(
//         data: (data) {
//           if (data == null) return const SizedBox();
//
//           Map<String, dynamic> options = (data);
//
//           if (!_paymentInitiated) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               initiatePayment(options);
//             });
//           }
//
//           return const Center(child: Text("Processing payment..."));
//         },
//         error: (error, stackTrace) => const Text("Error loading course data"),
//         loading: () => const Center(child: CircularProgressIndicator()),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    if (courseId == null) {
      return const Scaffold(
        body: Center(child: Text("Loading course information...")),
      );
    }

    return Consumer(
      builder: (context, ref, child) {
        final courseBuyData =
            ref.watch(buyCourseControllerProvider(index: int.parse(courseId!)));

        return Scaffold(
          body: courseBuyData.when(
            data: (data) {
              if (data == null) {
                return const Center(child: Text("No course data available"));
              }

              if (!_paymentInitiated) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  initiatePayment(data);
                });
              }

              return const Center(child: Text("Processing payment..."));
            },
            error: (error, stackTrace) => Center(child: Text("Error: $error")),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
