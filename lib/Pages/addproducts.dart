import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneymint/Controllers/auth_number.dart';
import 'package:moneymint/Controllers/cart_controller.dart';
import 'package:moneymint/Controllers/invoice_controller.dart';
import 'package:moneymint/Models/product_model.dart';
import 'package:moneymint/Pages/Shopping_cart.dart';

class addProducts extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final FirebaseFirestore dbs = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
       InvoiceController back = Get.put(InvoiceController());
    return Scaffold(
      
      appBar: AppBar(
        leading: back.backbutton(),
        backgroundColor: Color(0xff9474FF),
        title: Text(
          'Available Products',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            dbs.collection('User').doc(uid).collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(); // or a loading indicator
          }

          var products = snapshot.data!.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            return Products(
              id: doc.id,
              name: data['name'],
              sp: data['sp'],
              cp: '',
              hsn: '',
            );
          }).toList();

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  for (var product in products)
                    Card(
                      child: ListTile(
                        title: Text('${product.name}'),
                        subtitle: Text(' ₹${product.sp}'),
                        trailing: Container(
                          height: 35,
                          //width: 95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff9474FF),
                          ),
                          child: TextButton(
                            onPressed: () {
                              cartController.addToCart(product);
                            },
                            child: Text(
                              "Add To Cart",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => ShoppingCartPage());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff9474FF)),
                      child: Text('Go to Cart',
                          style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
