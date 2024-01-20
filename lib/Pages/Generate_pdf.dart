import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:moneymint/Controllers/cart_controller.dart';
import 'package:moneymint/Controllers/details_controller.dart';
import 'package:moneymint/Controllers/invoice_controller.dart';
import 'package:moneymint/Models/product_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWid;
import 'package:printing/printing.dart';

// ignore: must_be_immutable
class Pdfs extends StatelessWidget {
  List<Products> selectedProducts;
  final double totalPrice;
  Pdfs({
    super.key,
    required this.selectedProducts,
    required this.totalPrice,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PdfPreview(
            build: (format) => _createPdf(selectedProducts, totalPrice)));
  }
}

///////////////////////////////////////////////////////////
Future<Uint8List> _createPdf(
    List<Products> selectedProducts, double totalPrice) async {
  CartController cartController = Get.put(CartController());
  InvoiceController num = Get.put(InvoiceController());
  final selectedCustomerName =
      GetStorage().read('selectedCustomerName') ?? 'No Name';
  final selectedCustomerNumber =
      GetStorage().read('selectedCustomerNumber') ?? 'No Name';
  final date = GetStorage().read('date') ?? 'No Date';
  //final totalprice = GetStorage().write('totalprice', totalPrice);

  // print(selectedCustomerName);
  detailsControler details = Get.put(detailsControler());
  final pdf = pdfWid.Document(
    version: PdfVersion.pdf_1_5,
    compress: true,
  );
  pdf.addPage(pdfWid.Page(
    pageFormat: PdfPageFormat(300, 400),
    margin: pdfWid.EdgeInsets.all(10),
    build: (context) {
      return pdfWid.Column(children: [
        pdfWid.Row(
            mainAxisAlignment: pdfWid.MainAxisAlignment.center,
            children: [
              pdfWid.Column(
                //crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
                children: [
                  pdfWid.Text(details.userList.first.name),
                  pdfWid.Text(details.userList.first.address,
                      style: pdfWid.TextStyle(fontSize: 10)),
                  pdfWid.Text(details.userList.first.number,
                      style: pdfWid.TextStyle(fontSize: 10)),
                  pdfWid.Text(details.userList.first.gstNumber,
                      style: pdfWid.TextStyle(fontSize: 10)),
                ],
              ),
            ]),
        // pdfWid.Container(
        //   width: 50, // Adjust the size as needed
        //   decoration: pdfWid.BoxDecoration(
        //     shape: pdfWid.BoxShape.circle,
        //     color: PdfColors.blue,
        //   ),
        //   child: pdfWid.Center(
        //     child: pdfWid.Text(
        //       'A', // You can replace this with an initial or icon
        //       style: pdfWid.TextStyle(color: PdfColors.white),
        //     ),
        //   ),
        // ),
        // ),),
        /////////////////////
        pdfWid.SizedBox(height: 10),
        pdfWid.Container(
            height: 20,
            width: 300,
            color: PdfColors.deepPurpleAccent200,
            child: pdfWid.Center(
                child: pdfWid.Text("INVOICE",
                    style: pdfWid.TextStyle(
                        fontSize: 10, color: PdfColor.fromInt(0XffFFFFFF))))),
        //////////////////////
        pdfWid.SizedBox(height: 10),
        pdfWid.Row(children: [
          pdfWid.Column(
            crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
            children: [
              pdfWid.Text("BILLING DEATILS  ",
                  style: pdfWid.TextStyle(fontSize: 10)),
              pdfWid.Row(
                  crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
                  children: [
                    pdfWid.Text("Name : ",
                        style: pdfWid.TextStyle(fontSize: 10)),
                    pdfWid.Text('$selectedCustomerName',
                        style: pdfWid.TextStyle(fontSize: 10)),
                  ]),
              pdfWid.Row(
                  crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
                  children: [
                    pdfWid.Text("Phone No.: ",
                        style: pdfWid.TextStyle(fontSize: 10)),
                    pdfWid.Text(selectedCustomerNumber,
                        style: pdfWid.TextStyle(fontSize: 10)),
                  ]),
              pdfWid.SizedBox(height: 10),
              pdfWid.Row(
                  crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
                  children: [
                    pdfWid.Text("Order No.: ",
                        style: pdfWid.TextStyle(fontSize: 10)),
                    pdfWid.Text(num.currentInvoiceNumber.toString(),
                        style: pdfWid.TextStyle(fontSize: 10)),
                  ]),
            ],
          ),
          pdfWid.SizedBox(width: 50),
          pdfWid.Column(
            crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
            children: [
              pdfWid.Text("SHIPPING DEATILS  ",
                  style: pdfWid.TextStyle(fontSize: 10)),
              pdfWid.Row(
                  crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
                  children: [
                    pdfWid.Text("Name : ",
                        style: pdfWid.TextStyle(fontSize: 10)),
                    pdfWid.Text(selectedCustomerName,
                        style: pdfWid.TextStyle(fontSize: 10)),
                  ]),
              pdfWid.Row(
                  crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
                  children: [
                    pdfWid.Text(" Phone No.: ",
                        style: pdfWid.TextStyle(fontSize: 10)),
                    pdfWid.Text(selectedCustomerNumber,
                        style: pdfWid.TextStyle(fontSize: 10)),
                  ]),
              pdfWid.SizedBox(height: 10),
              pdfWid.Row(
                  crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
                  children: [
                    pdfWid.Text("Order Date: ",
                        style: pdfWid.TextStyle(fontSize: 10)),
                    pdfWid.Text("$date", style: pdfWid.TextStyle(fontSize: 10)),
                  ]),
            ],
          ),
        ]),
        pdfWid.Divider(borderStyle: pdfWid.BorderStyle.dashed),
        pdfWid.Row(
            mainAxisAlignment: pdfWid.MainAxisAlignment.spaceBetween,
            children: [
              pdfWid.Text("Particular",
                  style: pdfWid.TextStyle(fontWeight: pdfWid.FontWeight.bold)),
              pdfWid.SizedBox(width: 1),
              pdfWid.Text("Qty",
                  style: pdfWid.TextStyle(fontWeight: pdfWid.FontWeight.bold)),
              pdfWid.Text("Rate",
                  style: pdfWid.TextStyle(fontWeight: pdfWid.FontWeight.bold)),
              pdfWid.Text("Total",
                  style: pdfWid.TextStyle(fontWeight: pdfWid.FontWeight.bold)),
            ]),
        pdfWid.SizedBox(height: 10),
        pdfWid.ListView(children: [
          for (var product in selectedProducts)
            pdfWid.Row(
                mainAxisAlignment: pdfWid.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pdfWid.CrossAxisAlignment.end,
                children: [
                  pdfWid.Container(
                    width: 100,
                    //color: PdfColors.amber,
                    child: pdfWid.Text('${product.name}'),
                  ),
                  pdfWid.Container(
                    width: 20,
                    //color: PdfColors.amber,
                    child: pdfWid.Center(
                      child: pdfWid.Text(
                          '${cartController.cartItems.firstWhere((item) => item.product.name == product.name).quantity.value}'),
                    ),
                  ),
                  pdfWid.Container(
                    width: 40,
                    //color: PdfColors.amber,
                    child: pdfWid.Center(child: pdfWid.Text('${product.sp}')),
                  ),
                  pdfWid.Container(
                    width: 40,
                    child: pdfWid.Center(
                      child: pdfWid.Text(
                          '${double.parse(product.sp) * (cartController.cartItems.firstWhere((item) => item.product.name == product.name).quantity.value)}'),
                    ),
                  ),
                  //
                ]),
          pdfWid.SizedBox(height: 10),
          // pdfWid.Text('SubTotal: ${totalPrice}'),
          pdfWid.Padding(
            padding: pdfWid.EdgeInsets.only(left: 180),
            child: pdfWid.Container(
              child: pdfWid.Text('SubTotal: ${totalPrice}',
                  style: pdfWid.TextStyle(fontWeight: pdfWid.FontWeight.bold)),
            ),
          ),
        ]),
      ]);
    },
  ));
  return pdf.save();
}
