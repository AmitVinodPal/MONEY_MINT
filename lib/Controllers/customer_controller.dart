import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymint/Models/customer_model.dart';

class CustomerController extends GetxController {
  RxList<Customer> customerList = RxList<Customer>([]);
  TextEditingController cname = TextEditingController();
  TextEditingController cnumber = TextEditingController();
  final dbs = FirebaseFirestore.instance;
  var generatedId = "";

  // void onInit() {
  //   super.onInit();
  //   getCustomer(uid);
  //   print("came");
  // }

  // Future<void> addCustomer(userId) async {
  //   try {
  //     var add = Customer(
  //       id: '',
  //       name: cname.text,
  //       number: cnumber.text,
  //     );
  //     await dbs
  //         .collection("User")
  //         .doc(userId)
  //         .collection("customer")
  //         .doc()
  //         .set(add.toJson())
  //         .whenComplete(() => getCustomer(userId));
  //     printInfo(info: "User added successfully $userId");
  //   } catch (error) {
  //     Get.snackbar(
  //       "Error",
  //       "Failed to add user: $error",
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red.withOpacity(0.1),
  //       colorText: Colors.red,
  //     );
  //   }
  // }

  void addCustomer(userId) async {
    //print("hll");
    var connect = Customer(id: '', name: cname.text, number: cnumber.text);

    try {
      // Add the customer document to Firestore with a specific ID
      var docRef = await dbs
          .collection("User")
          .doc(userId)
          .collection("customer")
          .add(connect.toJson());

      // Get the generated ID from Firestore
      generatedId = docRef.id;

      // Update the customer document with its own ID
      await dbs
          .collection("User")
          .doc(userId)
          .collection("customer")
          .doc(generatedId)
          .update({"id": generatedId});
      //getCustomer(userId);
      printInfo(info: "Contact added with ID: $generatedId");
    } catch (error) {
      print("Error adding contact: $error");
    }
  }

  // void getCustomer(userId) {
  //   dbs
  //       .collection("User")
  //       .doc(userId) // Specify the user ID here
  //       .collection("customer")
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       print(element.data());
  //     });
  //   }).catchError((error) {
  //     print("Error getting customers: $error");
  //   });
  // }

  // void delete(userId) async {
  //   printInfo(info: "$userId");
  //   await dbs
  //       .collection("User")
  //       .doc(userId)
  //       .collection("customer")
  //       .doc()
  //       .delete()
  //       .whenComplete(() => printInfo(info: "Customer delete"));
  //   getCustomer(userId);
  // }
  void delete(String userId, String generatedId) async {
    try {
      await dbs
          .collection("User")
          .doc(userId)
          .collection("customer")
          .doc(generatedId)
          .delete()
          .whenComplete(() => printInfo(info: "Customer deleted"));
      getCustomer(userId); // Assuming this function refreshes the customer list
    } catch (e) {
      print("Error deleting customer: $e");
    }
  }

  Future getCustomer(uid) async {
    await dbs
        .collection("User")
        .doc(uid) // Specify the user ID here
        .collection("customer")
        .get()
        .then((value) {
      customerList.value =
          value.docs.map((e) => Customer.fromJson(e.data())).toList();
    });
  }
}
