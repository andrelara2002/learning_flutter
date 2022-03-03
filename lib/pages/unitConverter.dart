import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget unitConverter() {
  return UnitConverter();
}

class UnitConverter extends StatefulWidget {
  createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  var state = {'counter': 0};

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit conversor'),
      ),
      body: Center(
        child: Text('${state['counter']}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            setState(() => state.update('counter', (value) => value += 1)),
      ),
    );
  }
}
