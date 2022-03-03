import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_flutter/utils/menu.dart';

import './pages/calculator.dart';
import './pages/contacts.dart';
import './pages/unitConverter.dart';
import './pages/counter.dart';

class App extends StatelessWidget {
  var MenuList = [
    new Menu(Icons.calculate_rounded, 'Calculator', calculator()),
    new Menu(Icons.contact_phone_rounded, 'Contacts', contacts()),
    new Menu(Icons.ad_units_rounded, 'Units Converter', unitConverter()),
    new Menu(Icons.numbers_rounded, 'Counter', counter())
  ];

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.black,
          child: OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return ListView(
                    children: MenuList.map((item) => MenuItem(item)).toList());
              } else {
                return GridView.count(
                    crossAxisCount: 2,
                    children: MenuList.map((item) => MenuItem(item)).toList());
              }
            },
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  var item;

  MenuItem(item) {
    this.item = item;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      child: Material(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => item.page,
          )),
          child: Container(
            child: Row(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Icon(
                      item.icon,
                      color: Colors.amber,
                    ),
                  ),
                ),
                Text(
                  '${item.text}',
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main(List<String> args) {
  runApp(App());
}
