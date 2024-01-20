import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:moneymint/Controllers/auth_number.dart';

class otp extends StatelessWidget {
  const otp({super.key});

  @override
  Widget build(BuildContext context) {
    authwithnumber otpController = Get.put(authwithnumber());
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            // scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        //color: Colors.amber,
                        image: DecorationImage(
                            image: AssetImage("assets/otp.jpg"),
                            fit: BoxFit.fill)),
                  ),
                ),
                Text(
                  "ENTER OTP",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Please enter the otp that you have receive on the given number",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: otpController.otps,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "ENTER OTP"),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      // Get.off(home());
                      otpController.verifyOtp();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff9474FF)),
                    child: Center(
                      child: Container(
                        //width: 200,
                        child: Center(
                          child: Text(
                            "Done",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
