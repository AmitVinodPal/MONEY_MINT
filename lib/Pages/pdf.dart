import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymint/Controllers/auth_number.dart';
import 'package:moneymint/Controllers/details_controller.dart';
import 'package:moneymint/Pages/Bottom-nav.dart';

class pdf extends StatelessWidget {
  const pdf({super.key});
  @override
  Widget build(BuildContext context) {
    detailsControler details = Get.put(detailsControler());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff9474FF),
          title: Text(
            "Select Invoice",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: FutureBuilder(
            future: details.getUser(uid),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     await details.getUser(uid);
                  //     print(uid);
                  //   },
                  //   child: Text("Templeates"),
                  // ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width,
                    child: Obx(
                      () => ListView(
                        children: details.userList
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  // child: ListTile(
                                  //   tileColor: Colors.black54,
                                  //   textColor: Colors.tealAccent,
                                  //   title: Text(e.name),
                                  //   leading: Icon(
                                  //     Icons.favorite_outlined,
                                  //     color: Colors.red,
                                  //   ),
                                  //   subtitle: Text(
                                  //     e.email,
                                  //     style: TextStyle(color: Colors.purpleAccent[200]),
                                  //   ),
                                  // ),
                                  child: Container(
                                    //color: Colors.amber,
                                    // height: Get.height,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(e.name),
                                            Text(e.email),
                                            Text(e.number),
                                            Text(e.address),
                                            Text(e.panCard),
                                            Text(e.gstNumber),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              height: 30,
                                              width: 350,
                                              color: Color(0xff9474FF),
                                              child: Center(
                                                  child: Text(
                                                "INVOICE",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                            ),
                                            // SizedBox(
                                            //   height: 20,
                                            // ),
                                            Padding(
                                              padding: const EdgeInsets.all(1),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Billing Details",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text("Name: XYZ"),
                                                      Text(
                                                          "Number: 1234567890"),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Shipping Details",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text("Name: XYZ"),
                                                      Text(
                                                          "Number: 1234567890"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Order No: 000001",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Order Date: 07-11-2024",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.black,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Products"),
                                                  Text("Rate"),
                                                  Text("Qty"),
                                                  Text("Total"),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Dairy Milk"),
                                                  Text("20"),
                                                  Text("2"),
                                                  Text("40"),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.black,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 225),
                                              child: Row(
                                                children: [
                                                  Text("Subtotal"),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text("40"),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            GestureDetector(
                                              //onTap: () => validate.onValidate(),
                                              // onTap: () => bottom(),
                                              onTap: () {
                                                //pass.adduser();
                                                Get.off(bottom());
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 300,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  color: Color(0xff9474FF),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "Continue",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
