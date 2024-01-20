import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:moneymint/Controllers/auth_number.dart';
import 'package:moneymint/Controllers/cart_controller.dart';
import 'package:moneymint/Controllers/invoice_controller.dart';
import 'package:moneymint/Models/payments_model.dart';

class paidController extends GetxController {
  CartController cart = Get.put(CartController());
  InvoiceController number = Get.put(InvoiceController());
  final selectedCustomerName =
      GetStorage().read('selectedCustomerName') ?? 'No Name';
  final date = GetStorage().read('date') ?? 'No Date';
  final id = GetStorage().read('selectedCustomerId') ?? 'No id';
  final total = GetStorage().read('totalprice');
  final dbs = FirebaseFirestore.instance;
  String Userid = '';
  String customerId = '';
  final invoice = GetStorage().read('_currentInvoiceNumber');
  RxDouble totalpaid = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    totalPaid(uid);
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
  //         .collection("paid")
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

  // void calculateTotalSum(uid) async {
  //   try {
  //     // Retrieve all customers
  //     QuerySnapshot customersSnapshot = await dbs
  //         .collection("User")
  //         .doc(uid) // Replace with the actual user ID
  //         .collection("customer")
  //         .get();

  //     // Iterate through each customer
  //     for (QueryDocumentSnapshot customerDocument in customersSnapshot.docs) {
  //       String customerId = customerDocument.id;

  //       // Retrieve all paid invoices for the current customer
  //       QuerySnapshot paidInvoicesSnapshot = await dbs
  //           .collection("User")
  //           .doc(uid) // Replace with the actual user ID
  //           .collection("customer")
  //           .doc(customerId)
  //           .collection("paid")
  //           .get();

  //       // Calculate the sum of 'totalprice' values for the current customer
  //       double totalSumForCustomer = 0.0;

  //       for (QueryDocumentSnapshot invoiceDocument
  //           in paidInvoicesSnapshot.docs) {
  //         var totalpriceValue = invoiceDocument['totalprice'];
  //         if (totalpriceValue is num) {
  //           totalSumForCustomer += totalpriceValue.toDouble();
  //         }
  //       }

  //       printInfo(
  //           info:
  //               'Total Sum of Paid Amounts for Customer $customerId: $totalSumForCustomer');
  //     }
  //   } catch (error) {
  //     print("Error calculating total sum: $error");
  //   }
  // }

  Future<void> totalPaid(uid) async {
    try {
      // Retrieve all customers
      QuerySnapshot customersSnapshot = await dbs
          .collection("User")
          .doc(uid) // Replace with the actual user ID
          .collection("customer")
          .get();

      // Calculate the total sum of 'totalprice' for all invoices across all customers
      double paid = 0.0;

      // Iterate through each customer
      for (QueryDocumentSnapshot customerDocument in customersSnapshot.docs) {
        String customerId = customerDocument.id;

        // Retrieve all paid invoices for the current customer
        QuerySnapshot paidInvoicesSnapshot = await dbs
            .collection("User")
            .doc(uid) // Replace with the actual user ID
            .collection("customer")
            .doc(customerId)
            .collection("paid")
            .get();

        // Calculate the sum of 'totalprice' values for the paid invoices of the current customer
        for (QueryDocumentSnapshot invoiceDocument
            in paidInvoicesSnapshot.docs) {
          var totalpriceValue = invoiceDocument['totalprice'];
          if (totalpriceValue is num) {
            paid += totalpriceValue.toDouble();
          }
        }

        totalpaid.value = double.parse(paid.toStringAsFixed(2).replaceAll(RegExp(r'0*$'), ''));
      }

      //printInfo(info: 'Total Sum of Total Prices for All Paid Invoices: $paid');
    } catch (error) {
      print("Error calculating total sum: $error");
    }
  }

  void addBills(uid, double total) async {
    try {
      // Ensure that generatedId is set in your CustomerController
      customerId = id;
      printInfo(info: customerId);

      // Initialize the paid object with data
      var paid = Payments(
        id: id,
        selectedCustomerName: selectedCustomerName,
        totalprice: total, // Add the total price here
        date: date,
        invoice: number.currentInvoiceNumber
            .toString(), // Add the invoice number or identifier here
        ispaid: true,
      );

      // Add payment information to Firestore
      var ref = await dbs
          .collection("User")
          .doc(uid)
          .collection("customer")
          .doc(customerId)
          .collection("paid")
          .add(paid.toJson());
      Userid = ref.id;
      printInfo(info: "Userid ${Userid}");
      await dbs
          .collection("User")
          .doc(uid)
          .collection("transaction")
          .add(paid.toJson());
    } catch (error) {
      print("Error adding payment: $error");
    }
  }

  // void deleteBills(uid) async {
  //   try {
  //     String customerId = id;
  //     print(customerId);
  //     // Assuming you have the document ID that you want to delete
  //     String documentId = id; // Replace with the actual document ID

  //     // Reference to the document to be deleted
  //     var documentReference = dbs
  //         .collection("User")
  //         .doc(uid)
  //         .collection("customer")
  //         .doc(customerId)
  //         .collection("paid")
  //         .doc(documentId);

  //     // Delete the document
  //     await documentReference.delete();

  //     printInfo(info: "Payment deleted successfully");
  //   } catch (error) {
  //     print("Error deleting payment: $error");
  //   }
  // }

  // void deleteBills(String userId, String generatedId) async {
  //   try {
  //     await dbs
  //         .collection("User")
  //         .doc(userId)
  //         .collection("customer")
  //         .doc(generatedId)
  //         .collection('paid')
  //         .doc()
  //         .delete()
  //         .whenComplete(() => printInfo(info: "Customer deleted"));
  //     //getCustomer(userId); // Assuming this function refreshes the customer list
  //   } catch (e) {
  //     print("Error deleting customer: $e");
  //   }
  // }

  void deleteBill(String uid, String customerId, String paidId) async {
    printInfo(info: "paidid${paidId}");
    try {
      // Delete the paid document from the 'paid' collection
      await dbs
          .collection("User")
          .doc(uid)
          .collection("customer")
          .doc(customerId)
          .collection("paid")
          .doc(paidId)
          .delete();

      // Delete the transaction document from the 'transaction' collection
      await dbs
          .collection("User")
          .doc(uid)
          .collection("transaction")
          .doc(paidId)
          .delete();

      print("Bill deleted successfully");
    } catch (error) {
      print("Error deleting bill: $error");
    }
  }
}
