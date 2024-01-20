import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymint/Controllers/auth_number.dart';
import 'package:moneymint/Controllers/details_controller.dart';
import 'package:moneymint/Controllers/invoice_controller.dart';
import 'package:moneymint/Controllers/paid_controller.dart';
import 'package:moneymint/Controllers/unpaid_controller.dart';
import 'package:moneymint/Pages/Bussiness_details.dart';
import 'package:moneymint/Pages/new_invoice.dart';

class home extends StatelessWidget {
  const home({super.key});

  get userData => details();

  @override
  Widget build(BuildContext context) {
    detailsControler details = Get.put(detailsControler());
    authwithnumber auth = Get.put(authwithnumber());
    paidController paids = Get.put(paidController());
    unpaidController unpaids = Get.put(unpaidController());
    InvoiceController num = Get.put(InvoiceController());
    Future<void> pay() async {
      unpaids.totalUnpaid(uid);
      paids.totalPaid(uid);
      Duration(seconds: 1);
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Home"),
      // ),
      body: FutureBuilder(
          future: details.getUser(uid),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return RefreshIndicator(
              onRefresh: () => pay(),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.92,
                    width: MediaQuery.of(context).size.width,
                    //color: Colors.blueAccent,
                    child: Obx(
                      () => ListView(
                        children: details.userList
                            //       ever([details.userList, paids.paid] as RxInterface<Object?>, (_) {
                            //   paids.totalPaid(uid);
                            // })
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            e.name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        PopupMenuButton(
                                            itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                      child: TextButton(
                                                          onPressed: () {
                                                            auth.logoutUser();
                                                          },
                                                          child: Text("LogOut",style: TextStyle(color: Color(0xff9474FF)),))
                                                      ),
                                                ]),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Card(
                                          elevation: 5,
                                          child: Container(
                                            height: 100,
                                            width: 150,
                                            //color: Colors.green.shade50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.green.shade50,
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 25),
                                                  child: Text("Recevied"),
                                                ),
                                                Text("₹ ${paids.totalpaid}",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Card(
                                          elevation: 5,
                                          child: Container(
                                            height: 100,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.red.shade50,
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 25),
                                                  child: Text("Pending"),
                                                ),
                                                Text("₹ ${unpaids.totalunpaid}",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 270),
                                      child: Text(
                                        "Recents",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Container(
                                        height: 420,
                                        //color: Colors.amber,
                                        child: StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('User')
                                              .doc(uid)
                                              .collection('transaction')
                                              .limit(10)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            }

                                            var data = snapshot.data?.docs;

                                            return ListView.builder(
                                              itemCount: data?.length ?? 0,
                                              itemBuilder: (context, index) {
                                                var document = data?[index];
                                                var name = document?[
                                                    'selectedCustomerName'];
                                                var date = document?['date'];
                                                var price =
                                                    document?['totalprice'];
                                                var ispaid =
                                                    document?['ispaid'];
                                                var invoice =
                                                    document?['invoice'];
                                                //var id = document?['id'];
                                                Color textcolor = ispaid
                                                    ? Colors.green
                                                    : Colors.red;

                                                return Card(
                                                    elevation: 5,
                                                    child: Container(
                                                        height: 90,
                                                        color: Colors.white60,
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        12.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "$name",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Text(
                                                                        "Invoice No: $invoice"),
                                                                    Text(
                                                                      'Date: $date',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        12.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "$price",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Text(
                                                                      '${ispaid ? 'Paid' : 'Unpaid'}',
                                                                      style: TextStyle(
                                                                          color:
                                                                              textcolor,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ])));
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        num.incrementInvoiceNumber();
                                        print(num.currentInvoiceNumber);
                                        Get.to(NewInvoice());
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          color: Color(0xff9474FF),
                                        ),
                                        child: Center(
                                            child: Text(
                                          "New Invoice",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    ),
                                  ]),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
