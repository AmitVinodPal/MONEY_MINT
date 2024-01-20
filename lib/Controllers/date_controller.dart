// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';


// class Date extends GetxController{
//   late DateTime selectedDate;
//     late String FormattedDate;
//   @override
//   void initState() {
//     super.initState();
//     selectedDate = DateTime.now();
//     FormattedDate = DateFormat("dd-MM-yyyy").format(selectedDate);
//   }
//   // DateTime selectedDate = DateTime.now();
//   //  String FormattedDate = DateFormat("dd-MM-yyyy").format();

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDate,
//         firstDate: DateTime(2015, 8),
//         lastDate: DateTime(2101));
//   if (picked != null){
//     print(picked);
//     setState(() {
//       FormattedDate = DateFormat("dd-MM-yyyy").format(picked);
//       print(FormattedDate);
//       selectedDate= picked;
//     });
//   }
//   }
// }