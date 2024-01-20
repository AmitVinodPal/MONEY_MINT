import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymint/Controllers/auth_number.dart';
import 'package:moneymint/Controllers/paid_controller.dart';
import 'package:moneymint/Models/user_model.dart';

class detailsControler extends GetxController {
  TextEditingController Bname = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Number = TextEditingController();
  TextEditingController Pan = TextEditingController();
  TextEditingController Gst = TextEditingController();
  RxList<Users> userList = RxList<Users>([]);

  paidController paid = Get.put(paidController());
  final db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Object? userData;
  String uniqueId = "";
//adding user from form to database
  void adduser() async {
    var connect = Users(
        id: uid.toString(),
        name: Bname.text,
        address: Address.text,
        email: Email.text,
        number: Number.text,
        panCard: Pan.text,
        gstNumber: Gst.text);
    db
        .collection("User")
        .doc(uid)
        .set(connect.toJson())
        .then((value) => printInfo(info: "done"))

        // await db
        //     .collection("User")
        //     .add(connect.toJson())
        //     .then((DocumentReference docid) => {
        //           db.collection("User").doc(docid.id).update({"id": docid.id})
        //         })
        //.whenComplete(() =>
        // Get.snackbar(
        //       "Success",
        //       "Your Details Has Been Added",
        //       snackPosition: SnackPosition.BOTTOM,
        //       backgroundColor: Colors.green.withOpacity(0.1),
        //       colorText: Colors.green,
        //     )
        //Get.off(pdf())
        //Get.off(customer()),
        //Get.off(home())
        // Get.off(customer())
        //getUser(userId)
        .catchError((Error, StackTrace) {
      Get.snackbar(
        "Success",
        "Your Details Has Been Added",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    });
  }

  //Getting user for pdf and home screen
  Future<void> getUser(String userId) async {
    uniqueId = userId;
    print(uniqueId);
    try {
      QuerySnapshot querySnapshot =
          await db.collection("User").where("id", isEqualTo: userId).get();
      //paid.totalPaid(uid);

      if (querySnapshot.docs.isNotEmpty) {
        // Retrieve the user data
        userData = querySnapshot.docs.first.data();
        userList.value = querySnapshot.docs
            .map((doc) => Users.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        // Do something with the user data
        //print("User found: $userData");
        // print(userId);
        // print(userList);
      } else {
        print("User not found");
      }
    } catch (e) {
      print("Error retrieving user: $e");
    }
  }
}
