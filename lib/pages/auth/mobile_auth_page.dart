import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:tktodoprimal/repositories/auth/auth_repository.dart';

class MobileAuthPage extends StatefulWidget {
  static const routeName = "/mobileauth";
  const MobileAuthPage({super.key});

  @override
  State<MobileAuthPage> createState() => _MobileAuthPageState();
}

class _MobileAuthPageState extends State<MobileAuthPage> {
  AuthRepository authRepository = AuthRepository();
  final TextEditingController phoneTextController = TextEditingController();
  String verificationID = "";
  String smsCode = "";
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: 375,
        height: 667,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              phoneTextField(phoneTextController),
              const SizedBox(
                height: 20,
              ),
              _leadingText(),
              const SizedBox(
                height: 30,
              ),
              phoneOTPField(),
              const SizedBox(
                height: 40,
              ),
              _informationCounter(),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 60,
                width: 600,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text(
                    "Lets Go",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _leadingText() {
    return SizedBox(
      width: 345,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              height: 1,
              color: Colors.black,
            ),
          ),
          const Text(
            "Enter 6 Digit OTP",
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              height: 1,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  RichText _informationCounter() {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: "Send OTP Again in ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.tealAccent,
            ),
          ),
          TextSpan(
            text: "00:$start ",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.tealAccent,
            ),
          ),
          const TextSpan(
            text: "sec ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.tealAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget phoneTextField(TextEditingController phoneTextController) {
    return Container(
      width: 335,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.red[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your phone number",
          hintStyle: const TextStyle(
              color: Colors.black38, fontWeight: FontWeight.w600, fontSize: 17),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Text(
              "(+90)",
              style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: wait
                ? null
                : () async {
                    startTimer();
                    setState(() {
                      start = 30;
                      wait = true;
                      buttonName = "Re-Send";
                    });
                    await authRepository.verifyPhoneNumber(
                        "+90 ${phoneTextController.text}", context,setData);
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(
                buttonName,
                style: TextStyle(
                  color: wait ? Colors.white : Colors.black38,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget phoneOTPField() {
    return OTPTextField(
      otpFieldStyle: OtpFieldStyle(
          backgroundColor: Colors.white, borderColor: Colors.red[900]!),
      length: 6,
      width: 375,
      fieldWidth: 50,
      style: const TextStyle(fontSize: 17),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.box,
      onChanged: (value) {
        log("Changed: $value");
      },
      onCompleted: (value) {
        log("Completed: $value");
      },
    );
  }

  void startTimer() {
    const onSec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onSec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  void setData(verificationId) {
    setState(() {
      verificationID = verificationId;
    });
    startTimer();
  }
}
