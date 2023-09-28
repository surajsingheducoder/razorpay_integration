import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../widgets/textfield_widget.dart';

class PayThroughAdd extends StatefulWidget {
  const PayThroughAdd({super.key});

  @override
  State<PayThroughAdd> createState() => _PayThroughAddState();
}

class _PayThroughAddState extends State<PayThroughAdd> {

  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController description = TextEditingController();

  late Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    initializeRazorPay();
  }

  void initializeRazorPay(){
    _razorpay = Razorpay();
    
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  }

  void lunchRazorPay(){
    //here we will get value from text field controller
    int amountToPay = int.parse(amount.text)*100;

    //here parameter
    var options = {
      'key':'rzp_test_eKeKIpe4Wt30sG',
      'amount':"$amountToPay", //Rs = 200
      'name': name.text,
      'description': description.text,
      'prefill':{'contact': phone.text,'email': email.text},
    };


    try{
      _razorpay.open(options);
    }
    catch(e){
      print("Error : $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response){
    print("Payment Success");
    print("${response.orderId} /n ${response.paymentId} /n ${response.signature}");
    Fluttertoast.showToast(msg: "Payment Success ${response.orderId} - ${response.paymentId} - ${response.signature}");
  }

  void _handlePaymentError(PaymentFailureResponse response){
    print("Payment Failed");
    print("${response.code} /n ${response.message}");
    Fluttertoast.showToast(msg: "Payment Failed ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response){
    print("Payment Failed");
    Fluttertoast.showToast(msg: "External_Wallet is ${response.walletName}", timeInSecForIosWeb: 4);
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("RazorPay"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Pay through add money"),
            ),
            textField(size, "Name", false, name),
            textField(size, "Phone no.", false, phone),
            textField(size, "Email", false, email),
            textField(size, "Amount", true, amount),
            textField(size, "Description", false, description),
            ElevatedButton(onPressed: () {
              lunchRazorPay();
            }, child: Text("Pay now"))
          ],
        ),
      ),
    );
  }
}
