import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:moneymint/Pages/Bottom-nav.dart';
import 'package:moneymint/Pages/Bussiness_type.dart';
import 'package:moneymint/Pages/Otp.dart';
import 'package:moneymint/Pages/Signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:facebook_login/facebook_login.dart';

// its a user of firebase
var uid = "";

class authwithnumber extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController number = TextEditingController();
  TextEditingController otps = TextEditingController();
  String verifyId = "";

// auth for number
  void signupNumber() async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: "+91${number.text}",
          verificationCompleted: (PhoneAuthCredential credential) {
            print(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            print(e);
          },
          codeSent: (String verificationId, int? resendToken) {
            verifyId = verificationId;
            Get.snackbar("OTP Sended",
                "Otp sended on your mobile number ${number.text}");
            Get.to(otp());
            uid = number.text;
            //uid = email.toString();

            //printInfo(info: " verify id : $verifyId");
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (ex) {
      print(ex);
    }
  }
//verfying otp
  void verifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifyId,
        smsCode: otps.text,
      );
      var user = await auth.signInWithCredential(credential);
      print(user.additionalUserInfo!.isNewUser );
      if (user.additionalUserInfo!.isNewUser ) {
        Get.snackbar("OTP VERIFIED", "");
        Get.off(bussinessType());
      } else {
        // Obtain shared preferences.
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', 'number');
        await prefs.setString('uid',"");
        print(uid);
        print(number);
        Get.offAll(bottom());
      }
    } catch (ex) {
      Get.snackbar("$ex", "");
      print(ex);
    }
  }
// logout 
  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await auth.signOut();
    await _googleSignIn.signOut();
    await FacebookAuth.instance.logOut() ;
    Get.to(signup());
  }

//auth with google
  final GoogleSignIn _googleSignIn = GoogleSignIn();
    Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final email =googleSignInAccount!.email.toString();
  uid = email;
      print(uid);
      print(googleSignInAccount);
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      print(googleSignInAuthentication);
      final AuthCredential googleemail = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      print(googleemail);
      final UserCredential authResult = await auth.signInWithCredential(googleemail);
      if (authResult.additionalUserInfo!.isNewUser) {
        Get.snackbar("SuccessFull Signed In With Google", "");
        Get.off(bussinessType());
      } else {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', 'email');
        print(uid);
        print(email);
        Get.offAll(bottom());
      }
      return authResult.user;
     // print(authResult.user);
    } catch (error) {
      print("Google Sign-In Error: $error");
      return null;
    }
  }
  //auth with facebook
Future<User?> loginWithFacebook() async {
    try {
      // Log in with Facebook
      final result = await FacebookAuth.instance.login();
      print("Result:${result}");
      // Check if the login was successful
      if (result.status == LoginStatus.success) {
        // Access the user's token and profile information
        final AccessToken accessToken = result.accessToken!;
        final Map<String, dynamic> userData =
            await FacebookAuth.instance.getUserData();
        print("Facebook login successful!");
        print("Access Token: ${accessToken.token}");
        print("User Data: $userData");
        print(userData.values.elementAt(0));
        uid = userData.values.elementAt(0);
        // Proceed with your logic after successful login
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);
        final UserCredential authResult =
            await auth.signInWithCredential(credential);
            if (authResult.additionalUserInfo!.isNewUser) {
        Get.snackbar("SuccessFull Signed In With Facebook", "");
        Get.off(bussinessType());
      } else {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', '');
        print(uid);
       // print();
        Get.offAll(bottom());
      }
        print(authResult.additionalUserInfo!.isNewUser);
        if (authResult.additionalUserInfo!.isNewUser) {
          print("SuccessFull Signed In With Firebase");
        }
      }
    } catch (e) {
      print("Error during Facebook login: $e");
    }
    return null;
  }
}