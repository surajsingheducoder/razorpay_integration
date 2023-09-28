import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:razorpay_integration/razorpay/pay_through_add/pay_through_add.dart';

class RazorPayPayment extends StatefulWidget {
  const RazorPayPayment({super.key});

  @override
  State<RazorPayPayment> createState() => _RazorPayPaymentState();
}

class _RazorPayPaymentState extends State<RazorPayPayment> {

  Razorpay? _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response){
  Fluttertoast.showToast(msg: "Success Payment ${response.paymentId}", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: "Error Here ${response.code} - ${response.message}", timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response){
    Fluttertoast.showToast(msg: "External_Wallet is ${response.walletName}", timeInSecForIosWeb: 4);
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void makePayment() async {
    var options = {
      'key':'rzp_test_eKeKIpe4Wt30sG',
      'amount': 20000, //Here amount*100 = Rs 200
      'name':'Suraj',
      'description':'Shoes',
      'prefill':{'contact':'9162509629','email':'surajsingh.edugaon@gmail.com'},
    };

    try{
      _razorpay?.open(options);
    }
    catch(e){
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("RazorPay"),
        actions: [
          IconButton(onPressed: () {
              Get.to(() => const PayThroughAdd());
          }, icon: Icon(Icons.navigate_next))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         const Text("buy through click on button"),
          Card(
            child: ListTile(
              leading: Image.network("https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers-thumbnail.png"),
            title: Text("Shoes"),
              subtitle: Text("Sell Your Kindey and but it now"),
              trailing: ElevatedButton(onPressed: () {
                makePayment();
              }, child: Text("Buy now")),
            ),
          ),
        ],
      ),
    );
  }

}
