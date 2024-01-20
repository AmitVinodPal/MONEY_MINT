import 'package:flutter/material.dart';
import 'package:moneymint/Home.dart';
import 'package:moneymint/Pages/Customer.dart';
import 'package:moneymint/Pages/Products.dart';
import 'package:moneymint/Pages/status.dart';

class bottom extends StatefulWidget {
  const bottom({super.key});

  @override
  State<bottom> createState() => _bottomState();
}

class _bottomState extends State<bottom> {
  int cindex = 0;
  final List<Widget> _pages = [
    home(),
    Status(),
    products(),
    customer(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[cindex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xff9474FF),
          unselectedItemColor: Colors.grey[700],
          currentIndex: cindex,
          onTap: (int index) {
            setState(() {
              cindex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_rounded),
              label: 'Status',
            ),
            BottomNavigationBarItem(
              //icon: Icon(Icons.add_box),
              icon: Icon(Icons.account_tree_outlined),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Customer',
            ),
          ]),
    );
  }
}
