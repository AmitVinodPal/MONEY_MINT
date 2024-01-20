import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymint/Models/product_model.dart';

class productController extends GetxController {
  RxList<Products> productsList = RxList<Products>([]);
  TextEditingController pname = TextEditingController();
  TextEditingController pnumber = TextEditingController();
  TextEditingController selling = TextEditingController();
  TextEditingController cost = TextEditingController();
  final dbs = FirebaseFirestore.instance;
  var generatedId = "";
  void addProducts(userId) async {
    //print("hll");
    var connect = Products(
        id: '',
        name: pname.text,
        hsn: pnumber.text,
        sp: selling.text,
        cp: cost.text);

    try {
      // Add the customer document to Firestore with a specific ID
      var docRef = await dbs
          .collection("User")
          .doc(userId)
          .collection("products")
          .add(connect.toJson());

      // Get the generated ID from Firestore
      generatedId = docRef.id;

      // Update the customer document with its own ID
      await dbs
          .collection("User")
          .doc(userId)
          .collection("products")
          .doc(generatedId)
          .update({"id": generatedId});
      //getCustomer(userId);

      printInfo(info: "Contact added with ID: $generatedId");
    } catch (error) {
      print("Error adding contact: $error");
    }
  }

  void productDelete(String userId, String generatedId) async {
    try {
      await dbs
          .collection("User")
          .doc(userId)
          .collection("products")
          .doc(generatedId)
          .delete()
          .whenComplete(() => printInfo(info: "products deleted"));
      getProducts(userId); // Assuming this function refreshes the customer list
    } catch (e) {
      print("Error deleting products: $e");
    }
  }

  Future getProducts(uid) async {
    await dbs
        .collection("User")
        .doc(uid) // Specify the user ID here
        .collection("products")
        .get()
        .then((value) {
      productsList.value =
          value.docs.map((e) => Products.fromJson(e.data())).toList();
    });
  }
}
