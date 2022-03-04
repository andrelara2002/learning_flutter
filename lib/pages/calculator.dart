import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget calculator() {
  return Calculator();
}

class Calculator extends StatefulWidget {
  createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var history = [];
  var state = {
    'operation': '',
    'value': 0,
    'second_value': '',
    'memory_pool': '',
    'third_number': ''
  };

  void handleOperator(key) {
    switch (key.type) {
      case 'number':
        if (state['value'].toString().length <= 9) {
          setState(() => state.update(
              'value',
              (value) => value = value.toString() != '0'
                  ? value.toString() + key.character.toString()
                  : value.toString().replaceFirst('0', '') +
                      key.character.toString()));
        }
        break;

      case 'operator':
        state.update(
            'memory_pool',
            (value) => value = double.parse(state['value']
                .toString())); // Store the number to be used on the operation
        setState(() {
          if (key.character != '=') {
            state.update('operation', (value) => value = key.character);
            state.update(
                'second_value', (value) => value = state['value'].toString());
            state.update('third_number', (value) => value = '');

            state.update('value', (value) => value = 0);
          } else
            calculate();
        });
        break;

      case 'setting':
        switch (key.character) {
          case 'AC': //Clear the entire panel and memory
            setState(() {
              state.update('operation', (value) => value = '');
              state.update('value', (value) => value = 0);
              state.update('second_value', (value) => value = '');
              state.update('memory_pool', (value) => value = '');
              state.update('third_number', (value) => value = '');
            });
            break;
          case 'C': // Clear the last number of panel
            setState(() {
              var _value = state['value'].toString();
              state.update('value',
                  (value) => value = _value.substring(0, _value.length - 1));
            });
            break;
          default:
        }
        break;

      default:
    }
  }

  void calculate() {
    double result = 0.0;
    String operation = state['operation'].toString();

    var first_value = double.parse(state['second_value'].toString());
    var second_value = double.parse(state['memory_pool'].toString());

    switch (operation) {
      case '+':
        result = first_value + second_value;
        break;
      case '-':
        result = first_value - second_value;
        break;
      case 'x':
        result = first_value * second_value;
        break;
      case '/':
        result = first_value / second_value;
        break;
      default:
    }

    setState(() {
      state.update(
          'third_number', (value) => value = state['value'].toString());
      state.update('memory_pool', (value) => value = result);
      state.update(
          'value',
          (value) => value = result.toString().split('.')[1].length > 2
              ? result.toStringAsPrecision(8)
              : result);

      history.add(state);
    });
  }

  Widget KeyBoard() {
    var keys = [
      new Key('AC', 'setting'),
      new Key('()', 'setting'),
      new Key('C', 'setting'),
      new Key('/', 'operator'),
      new Key('7', 'number'),
      new Key('8', 'number'),
      new Key('9', 'number'),
      new Key('x', 'operator'),
      new Key('4', 'number'),
      new Key('5', 'number'),
      new Key('6', 'number'),
      new Key('-', 'operator'),
      new Key('1', 'number'),
      new Key('2', 'number'),
      new Key('3', 'number'),
      new Key('+', 'operator'),
      new Key('+/-', 'number'),
      new Key('0', 'number'),
      new Key('.', 'number'),
      new Key('=', 'operator'),
    ];

    return GridView.count(
      crossAxisCount: 4,
      padding: EdgeInsets.all(20),
      children: keys
          .map((key) => Container(
                margin: EdgeInsets.all(8),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 0, 0, 0),
                  child: InkWell(
                    onTap: () => handleOperator(key),
                    child: Center(
                      child: Text(
                        '${key.character}',
                        style: TextStyle(
                            color: key.type == 'number'
                                ? Colors.white
                                : key.type == 'setting'
                                    ? Colors.amber
                                    : Colors.greenAccent,
                            fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext builder) {
    var aspect_ratio =
        MediaQuery.of(context).size.aspectRatio; // 0.45 - S20 FE / 1.78 - S7

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 30, bottom: 10),
                        child: SizedBox(
                          height: 103,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  '${state['second_value']} ${state['operation']} ${state['third_number']}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 26),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  '${state['value']}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 62,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        )),
                  ))),
          Expanded(
              flex: aspect_ratio < 1 ? 3 : 6,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(255, 26, 26, 26),
                ),
                child: KeyBoard(),
              ))
        ],
      ),
    );
  }
}

class Key {
  var character;
  var type;

  Key(character, type) {
    this.character = character;
    this.type = type;
  }
}
