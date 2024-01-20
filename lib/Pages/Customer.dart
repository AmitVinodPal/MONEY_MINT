import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymint/Controllers/auth_number.dart';
import 'package:moneymint/Controllers/customer_controller.dart';

class customer extends StatelessWidget {
  const customer({super.key});

  @override
  Widget build(BuildContext context) {
    CustomerController customer = CustomerController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff9474FF),
          title: Text(
            "Customers",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          // backgroundColor: Colors.indigo,
        ),
        body: FutureBuilder(
            future: customer.getCustomer(uid),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        //color: Colors.amber,
                        child: Obx(
                          () => ListView(
                            children: customer.customerList
                                .map(
                                  (e) => Card(
                                    elevation: 5,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Container(
                                        height: 90,
                                        child: ListTile(
                                          tileColor: Colors.white,
                                          title: Text(
                                            e.name.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(e.number.toString()),
                                          trailing: IconButton(
                                              onPressed: () {
                                                customer.delete(
                                                    uid, e.id.toString());
                                              },
                                              icon: Icon(
                                                CupertinoIcons.trash,
                                                color: Colors.blue[900],
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ElevatedButton(
                        //     onPressed: () {
                        //       customer.getCustomer(uid);
                        //       // print("hy");
                        //       // print(uid);
                        //     },
                        //     child: Text("Call")),
                        Container(
                          width: 300,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.bottomSheet(
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    width:
                                        MediaQuery.of(context).size.width * 10,
                                    decoration: BoxDecoration(
                                        //color: Colors.deepPurple[100],
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: customer.cname,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              hintText: "Customer Name",
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                              controller: customer.cnumber,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: "Customer Number",
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                customer.addCustomer(uid);
                                                customer.getCustomer(uid);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xff9474FF)),
                                              child: Text("Submit",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ))),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff9474FF)),
                              child: Text(
                                "Add New Customer",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }));
  }
}
