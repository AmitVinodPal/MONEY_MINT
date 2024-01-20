import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymint/Controllers/auth_number.dart';
import 'package:moneymint/Pages/Bussiness_details.dart';
//import 'package:moneymint/Pages/Signup.dart';

class bussinessType extends StatefulWidget {
  const bussinessType({Key? key}) : super(key: key);

  @override
  State<bussinessType> createState() => _bussinessTypeState();
}

class _bussinessTypeState extends State<bussinessType> {
  String? selectedData;
 authwithnumber numcontroller = Get.put(authwithnumber());
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {"Label": "Retail", "value": "1"},
      {"Label": "Wholesaler", "value": "2"},
      {"Label": "Distributor", "value": "3"},
      {"Label": "Manufacturer", "value": "4"},
      {"Label": "Services", "value": "5"},
    ];

    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Text(
                  "Select Busienss Type",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              for (int i = 0; i < data.length; i++)
                Container(
                  //color: Colors.amberAccent,
                  child: Row(
                    children: [
                      Radio(
                        value: data[i]['value'],
                        groupValue: selectedData,
                        onChanged: (value) {
                          setState(() {
                            selectedData = value.toString();
                          });
                        },
                      ),
                      Text(
                        data[i]['Label'],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              //ElevatedButton(onPressed: () {}, child: Text("Continue"))
              GestureDetector(
                onTap: () => Get.off(details()),
                child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0xff9474FF),
                  ),
                  child: Center(
                      child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
