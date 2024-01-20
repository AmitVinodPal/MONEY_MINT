import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:moneymint/Controllers/auth_number.dart';
import 'package:moneymint/Controllers/cart_controller.dart';
import 'package:moneymint/Controllers/invoice_controller.dart';
import 'package:moneymint/Pages/Generate_pdf.dart';
import 'package:moneymint/Pages/addproducts.dart';

class NewInvoice extends StatefulWidget {
  NewInvoice({Key? key});

  @override
  State<NewInvoice> createState() => _NewInvoiceState();
}

class _NewInvoiceState extends State<NewInvoice> {
  CartController cart = Get.put(CartController());
  InvoiceController num = Get.put(InvoiceController());
  String selectedCustomer = "0";
  String selectedCustomerNumber = "";
  String selectedCustomerId = "";
  var customers;
  late DateTime selectedDate;
  late String FormattedDate;
  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    FormattedDate = DateFormat("dd-MM-yyyy").format(selectedDate);
  }
  // DateTime selectedDate = DateTime.now();
  //  String FormattedDate = DateFormat("dd-MM-yyyy").format();

//this for button
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null) {
  //     print(picked);
  //     setState(() {
  //       FormattedDate = DateFormat("dd-MM-yyyy").format(picked);
  //       print(FormattedDate);
  //       selectedDate = picked;
  //     });
  //   }
  // }

  void navigateToSelectedCustomerPage() {
    // Save selected customer information
    GetStorage().write('selectedCustomerName', selectedCustomer);
    GetStorage().write('selectedCustomerNumber', selectedCustomerNumber);
    GetStorage().write('selectedCustomerId', selectedCustomerId);
    GetStorage().write('date', FormattedDate);
    //print(FormattedDate);

    // Navigate to the new page
    Get.to(Pdfs(
      selectedProducts: cart.cartItems.map((item) => item.product).toList(),
      totalPrice: cart.totalPrice,
    ));
  }

  @override
  Widget build(BuildContext context) {
    // InvoiceController back = Get.put(InvoiceController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9474FF),
        leading: num.backbutton(),
        title: Text(
          'Create New Invoice',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 80,
                width: 300,
                //color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Text(
                              "Invoice No #${num.currentInvoiceNumber}",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          IconButton(
                              onPressed: () {
                                num.editInvoiceNumberDialog(context);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue,
                                size: 15,
                              ))
                        ],
                      ),
                      Text("$FormattedDate",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
              Divider(),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('User')
                    .doc(uid) // Specify the user ID here
                    .collection("customer")
                    .snapshots(),
                builder: (context, snapshot) {
                  List<DropdownMenuItem<String>> customerItems = [];
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator(); // Return a widget here
                  } else {
                    customers = snapshot.data?.docs;
                    customerItems.add(DropdownMenuItem(
                        value: "0", child: Text("Select Customer Name")));
                    for (var customer in customers!) {
                      customerItems.add(DropdownMenuItem(
                          value: customer['name'],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(customer['name']),
                          )));
                    }
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 150, top: 10, bottom: 10),
                        child: Text(
                          "Customer Name*",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                          height: 40,
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          //color: Colors.amber,
                          child: DropdownButton<String>(
                            items: customerItems,
                            onChanged: (customerName) {
                              print(customerName);
                              setState(() {
                                selectedCustomer = customerName!;
                                // Fetch and set the number based on the selected name

                                selectedCustomerId = getCustomerIdByName(
                                    customers!, customerName);

                                printInfo(info: '$selectedCustomerId');

                                selectedCustomerNumber =
                                    getCustomerNumberByName(
                                        customers!, customerName);
                              });
                            },
                            value: selectedCustomer,
                            isExpanded: true,
                          ),
                        ),
                      ),
                      // Display the selected customer number
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 130, top: 10, bottom: 10),
                        child: Text(
                          "Customer Number",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                            height: 40,
                            width: MediaQuery.sizeOf(context).width * 0.8,

                            ///color: Colors.amber,

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("$selectedCustomerNumber",
                                  style: TextStyle(fontSize: 15)),
                            )),
                      ),
                    ],
                  );
                },
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(right: 160, top: 5, bottom: 10),
                child: Text(
                  "Products",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    navigateToSelectedCustomerPage();
                    Get.to(addProducts());
                  },
                  child: Container(
                    height: 40,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffEBE5FF),
                    ),
                    child: Center(
                      child: Text(
                        "Add Products",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xff9474FF)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to get customer number by name
  String getCustomerNumberByName(
      List<QueryDocumentSnapshot<Object?>> customers, String name) {
    var customer = customers.firstWhere((customer) => customer['name'] == name);
    return customer['number'];
  }

  String getCustomerIdByName(
      List<QueryDocumentSnapshot<Object?>> customers, String name) {
    var customer = customers.firstWhere((customer) => customer['name'] == name);
    return customer.id;
  }
}
