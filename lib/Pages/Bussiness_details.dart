import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymint/Controllers/details_controller.dart';
import 'package:moneymint/Controllers/validateController.dart';

class details extends StatelessWidget {
  const details({super.key});

  @override
  Widget build(BuildContext context) {
    validateController validate = Get.put(validateController());
    detailsControler pass = Get.put(detailsControler());
    return Scaffold(
      body: Container(
          height: Get.height,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Text(
                  "Bussiness Details",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Form(
                    autovalidateMode: AutovalidateMode
                        .onUserInteraction, //this is for validation without button
                    key: validate.formKey,
                    child: Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(20),
                        children: [
                          TextFormField(
                            controller: pass.Bname,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: "Bussines Name*",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                )),
                            validator: (name) => validate.validateName(name),
                            textCapitalization: TextCapitalization.characters,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: pass.Address,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: "Address*",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                )),
                            validator: (address) =>
                                validate.validateAddress(address),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: pass.Email,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: "EmailId*",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                )),
                            validator: (email) => validate.validateEmail(email),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: pass.Number,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "Phone Number*",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                )),
                            validator: (number) =>
                                validate.validateNumber(number),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: pass.Pan,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: "PAN Number*",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                )),
                            validator: (pan) => validate.validatePan(pan),
                            textCapitalization: TextCapitalization.characters,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: pass.Gst,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: "GST Number*",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                )),
                            validator: (gst) => validate.validateGst(gst),
                            textCapitalization: TextCapitalization.characters,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              validate.onValidate();
                              pass.adduser();
                              //Get.off(bottom());
                            },
                            child: Container(
                              height: 40,
                              width: 200,
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
                          )
                        ],
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}
