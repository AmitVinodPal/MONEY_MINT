import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymint/Pages/pdf.dart';

class validateController extends GetxController {
  final formKey = GlobalKey<FormState>();
  validateName(String? name) {
    if (name != null && name.isNotEmpty) {
      return null;
    }
    return "Please Enter valid username";
  }

  validateAddress(String? address) {
    if (address != null && address.isNotEmpty) {
      return null;
    }
    return "Please Enter Address ";
  }

  validateEmail(String? email) {
    if (GetUtils.isEmail(email!)) {
      return null;
    }
    return "Please Enter Vaild Email";
  }

  validateNumber(String? number) {
    if (GetUtils.isPhoneNumber(number!)) {
      return null;
    }
    return "Please Enter Number ";
  }

  validatePan(String? pan) {
    if (GetUtils.isLengthGreaterThan(pan, 9) &&
        RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(pan!)) {
      // PAN number is valid (length is greater than 9)
      return null;
    }
    // PAN number is invalid
    return "Please Enter Vaild PAN Number";
  }

  validateGst(String? gst) {
    if (GetUtils.isLengthGreaterOrEqual(gst, 15) &&
        RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[Z]{1}[0-9]{1}$')
            .hasMatch(gst!)) {
      // PAN number is valid (length is greater than 9)
      return null;
    }
    // PAN number is invalid
    return "Please Enter Vaild GST Number";
  }

  Future onValidate() async {
    if (formKey.currentState!.validate()) {
      Get.offAll(() => pdf());
      Get.snackbar(
        'Success', 'Login Succesful',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.green,
        // backgroundColor: Colors.white
      );
      return;
    } else {
      Get.snackbar(
        "Failed", 'login failed',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
        //backgroundColor: Colors.white
      );
    }
  }
}
