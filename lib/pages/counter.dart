import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget counter() {
  return Converter();
}

class Converter extends StatefulWidget {
  createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  var state = {'counter': 0};

  void decreaseCount() {
    setState(() {
      state.update('counter', (value) => value -= 1);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        child: Center(
          child: Text(
            '${state['counter']}',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 42, color: Colors.white),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        splashColor: Colors.amberAccent,
        child: Icon(Icons.plus_one),
        onPressed: () =>
            setState(() => state.update('counter', (value) => value += 1)),
      ),
      bottomNavigationBar: BottomAppBar(
        //Changing the buttom to notched one
        shape: CircularNotchedRectangle(),
        color: Colors.amber,
        child: Row(
          children: [
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back_ios_new_rounded))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
