import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class InvoiceController extends GetxController {
  // final _currentInvoiceNumber = 0.obs; // Default starting invoice number

  // int get currentInvoiceNumber => _currentInvoiceNumber.value;

  // @override
  // void onInit() {
  //   super.onInit();
  //   loadInvoiceNumber();
  // }

  // Future<void> loadInvoiceNumber() async {
  //   final box = GetStorage();
  //   _currentInvoiceNumber.value = box.read('last_invoice_number') ?? 0;
  // }

  // Future<void> saveInvoiceNumber() async {
  //   final box = GetStorage();
  //   box.write('last_invoice_number', _currentInvoiceNumber.value);
  // }

  // void incrementInvoiceNumber() {
  //   _currentInvoiceNumber.value++;
  //   saveInvoiceNumber(); // Save the incremented invoice number
  // }

  // void editInvoiceNumber(int newInvoiceNumber) {
  //   _currentInvoiceNumber.value = newInvoiceNumber;
  //   saveInvoiceNumber(); // Save the edited invoice number
  // }

  final _currentInvoiceNumber = 0.obs; // Default starting invoice number

  int get currentInvoiceNumber => _currentInvoiceNumber.value;

  final TextEditingController _textFieldController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadInvoiceNumber();
  }

  Future<void> loadInvoiceNumber() async {
    final box = GetStorage();
    _currentInvoiceNumber.value = box.read('last_invoice_number') ?? 0;
  }

  Future<void> saveInvoiceNumber() async {
    final box = GetStorage();
    box.write('last_invoice_number', _currentInvoiceNumber.value);
  }

  void incrementInvoiceNumber() {
    _currentInvoiceNumber.value++;
    saveInvoiceNumber(); // Save the incremented invoice number
  }

  // void resetInvoiceNumber() {
  //   _currentInvoiceNumber.value = 0;
  //   saveInvoiceNumber(); // Save the reset invoice number
  // }

  void editInvoiceNumberDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter New Invoice Number'),
          content: TextField(
            controller: _textFieldController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'New Invoice Number',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Validate and update the invoice number
                if (_textFieldController.text.isNotEmpty) {
                  int newInvoiceNumber =
                      int.tryParse(_textFieldController.text) ?? 0;
                  editInvoiceNumber(newInvoiceNumber);
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void editInvoiceNumber(int newInvoiceNumber) {
    _currentInvoiceNumber.value = newInvoiceNumber;
    saveInvoiceNumber(); // Save the edited invoice number
  }

  Widget backbutton() {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
    );
  }
}
