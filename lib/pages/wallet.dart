import 'dart:convert';
import 'package:e_commerce/Widget/Widget_support.dart';
import 'package:e_commerce/Widget/app_constant.dart';
import 'package:e_commerce/service/database.dart';
import 'package:e_commerce/service/sharedsPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? wallet, id;
  int? add;
  TextEditingController AmountCounting = TextEditingController();
  getthesharedPrefernece() async {
    id = await SharedPreferenceHelper().getUserId();
    wallet = await SharedPreferenceHelper().getUserWallet();
    setState(() {});
  }

  onload() async {
    await getthesharedPrefernece();
    setState(() {});
  }

  @override
  void initState() {
    onload();
    super.initState();
  }

  Map<String, dynamic>? paymentIntent;
  final String secretKey =
      'YOUR_STRIPE_SECRET_KEY'; // Add your Stripe Secret Key here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wallet == null
          ? CircularProgressIndicator()
          : Container(
              margin: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Material(
                    elevation: 2,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Center(
                        child: Text(
                          "Wallet",
                          style: AppWidget.HeadlineTextFieldbold(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        Image.asset(
                          "img/wallet.png",
                          fit: BoxFit.cover,
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your wallet",
                              style: AppWidget.SemiboldTextFieldbold(),
                            ),
                            SizedBox(height: 5),
                            Text("\$" + wallet!,
                                style: AppWidget.boldTextFieldbold()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(padding: const EdgeInsets.only(left: 20)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Add money",
                      style: AppWidget.SemiboldTextFieldbold(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          makePayment("100");
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Text(
                            "\$100",
                            style: AppWidget.SemiboldTextFieldbold(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          makePayment("500");
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Text(
                            "\$500",
                            style: AppWidget.SemiboldTextFieldbold(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          makePayment("1000");
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Text(
                            "\$1000",
                            style: AppWidget.SemiboldTextFieldbold(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          makePayment("2000");
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Text(
                            "\$2000",
                            style: AppWidget.SemiboldTextFieldbold(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: (){
                      openEdit();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      width: MediaQuery.of(context).size.width / 1.1,
                      decoration: BoxDecoration(color: Colors.greenAccent),
                      child: Center(
                        child: Text(
                          "Add Money",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!["client_secret"],
              style: ThemeMode.dark,
              merchantDisplayName: 'Adnan',
            ),
          )
          .then((value) {});
      displayPaymentSheet(amount);
    } catch (e, s) {
      print("exception: $e $s");
    }
  }

  Future<void> displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        add = int.parse(wallet!) + int.parse(amount);
        await SharedPreferenceHelper().saveUserWallet(add.toString());
        await DatabaseMethods().UpdateUserWallet(id!, add.toString());
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                Text("Payment Successful"),
              ],
            ),
          ),
        );
        await getthesharedPrefernece();
        paymentIntent = null;
      }).onError((error, stackTrace) {
        print("Error is $error $stackTrace");
      });
    } on StripeException catch (e) {
      print("Error is:-- $e");
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text("Cancelled"),
        ),
      );
    } catch (e) {
      print("$e");
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          'Authorization': 'Bearer $secreteKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      print("Payment Intent Body->>> ${response.body.toString()}");
      return jsonDecode(response.body);
    } catch (err) {
      print("err charging user: ${err.toString()}");
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount) * 100);
    return calculatedAmount.toString();
  }

  Future openEdit() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.cancel),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Text("Amount"),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black45),
                      ),
                      child: TextField(
                        controller: AmountCounting,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter amount",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        makePayment(AmountCounting.text);
                      },
                      child: Container(
                        width: 100,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Pay",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
}
