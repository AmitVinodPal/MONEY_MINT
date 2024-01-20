import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:moneymint/Controllers/auth_number.dart';
import 'package:moneymint/Controllers/invoice_controller.dart';
import 'package:moneymint/Models/payments_model.dart';

class unpaidController extends GetxController {
  final selectedCustomerName =
      GetStorage().read('selectedCustomerName') ?? 'No Name';
  final date = GetStorage().read('date') ?? 'No Date';
  final id = GetStorage().read('selectedCustomerId') ?? 'No id';
  final dbs = FirebaseFirestore.instance;
    InvoiceController number = Get.put(InvoiceController());

  RxDouble totalunpaid = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    totalUnpaid(uid);
    super.onInit();
  }

  // void calculateTotalSum(uid) async {
  //   try {
  //     String customerId = id;
  //     print(customerId);

  //     // Retrieve all documents from the 'paid' collection
  //     QuerySnapshot querySnapshot = await dbs
  //         .collection("User")
  //         .doc(uid)
  //         .collection("customer")
  //         .doc(customerId)
  //         .collection("unpaid")
  //         .get();

  //     // Calculate the sum of 'totalprice' values
  //     double totalSum = 0.0;

  //     for (QueryDocumentSnapshot document in querySnapshot.docs) {
  //       var totalpriceValue = document['totalprice'];
  //       if (totalpriceValue is num) {
  //         totalSum += totalpriceValue.toDouble();
  //       }
  //     }

  //     printInfo(info: 'Total Sum of Total Prices: $totalSum');
  //   } catch (error) {
  //     print("Error calculating total sum: $error");
  //   }
  // }

  void totalUnpaid(uid) async {
    try {
      //Retrieve all customers
      QuerySnapshot customersSnapshot = await dbs
          .collection("User")
          .doc(uid) // Replace with the actual user ID
          .collection("customer")
          .get();

      // Calculate the total sum of 'totalprice' for all invoices across all customers
      double unpaid = 0.0;

      // // Iterate through each customer
      for (QueryDocumentSnapshot customerDocument in customersSnapshot.docs) {
        //Retrieve all unpaid invoices for the current customer
        String customerId = customerDocument.id;
        QuerySnapshot unpaidInvoicesSnapshot = await dbs
            .collection("User")
            .doc(uid) // Replace with the actual user ID
            .collection("customer")
            .doc(customerId)
            .collection("unpaid")
            .get();
        //Calculate the sum of 'totalprice' values for the unpaid invoices of the current customer
        for (QueryDocumentSnapshot invoiceDocument
            in unpaidInvoicesSnapshot.docs) {
          var totalpriceValue = invoiceDocument['totalprice'];
          if (totalpriceValue is num) {
            unpaid += totalpriceValue.toDouble();
          }
        }
        totalunpaid.value = double.parse(unpaid.toStringAsFixed(2).replaceAll(RegExp(r'0*$'), ''));
        // printInfo(info: "Total PAid $totalunpaid");
      }

      // printInfo(
      //  info: 'Total Sum of Total Prices for All unpaid Invoices: $unpaid');
    } catch (error) {
      print("Error calculating total sum: $error");
    }
  }

  void addBills(uid, double total) async {
    try {
      // Ensure that generatedId is set in your CustomerController
      String customerId = id;
      print(customerId);

      // Initialize the paid object with data
      var paid = Payments(
        id: id,
        selectedCustomerName: selectedCustomerName,
        totalprice: total, // Add the total price here
        date: date,
        invoice: number.currentInvoiceNumber
            .toString(), // Add the invoice number or identifier here
        ispaid: false,
      );

      // Add payment information to Firestore
      await dbs
          .collection("User")
          .doc(uid)
          .collection("customer")
          .doc(customerId)
          .collection("unpaid")
          .add(paid.toJson());
      await dbs
          .collection("User")
          .doc(uid)
          .collection("transaction")
          .add(paid.toJson());
    } catch (error) {
      print("Error adding payment: $error");
    }
  }
}
