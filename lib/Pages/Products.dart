import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymint/Controllers/auth_number.dart';
import 'package:moneymint/Controllers/products_controller.dart';

class products extends StatelessWidget {
  const products({super.key});

  @override
  Widget build(BuildContext context) {
    productController products = productController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff9474FF),
          title: Text(
            "Products",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          // backgroundColor: Colors.indigo,
        ),
        body: FutureBuilder(
            future: products.getProducts(uid),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.amber,
                      child: Obx(
                        () => ListView(
                          children: products.productsList
                              .map(
                                (e) => Card(
                                  elevation: 5,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Container(
                                      height: 80,
                                      child: ListTile(
                                        tileColor: Colors.white,
                                        title: Text(
                                          e.name.toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle:
                                            Text("₹${e.sp.toString()}/per"),
                                        trailing: IconButton(
                                            onPressed: () {
                                              products.productDelete(
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
                      //       products.getProducts(uid);
                      //       // customer.getCustomer(uid);
                      //       // print("hy");
                      //       // print(uid);
                      //     },
                      //     child: Text("Call")),
                      Container(
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.bottomSheet(
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                    //color: Colors.white,
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
                                            controller: products.pname,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              hintText: "Product Name",
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                              controller: products.pnumber,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: "HSN Number",
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                              controller: products.selling,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: "Selling Price",
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                              controller: products.cost,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: "Cost Price",
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                products.addProducts(uid);
                                                products.getProducts(uid);
                                                //customer.getCustomer(uid);
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
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff9474FF)),
                            child: Text(
                              "Add New Products",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                      ),
                    ],
                  ),
                ],
              );
            }));
  }
}
