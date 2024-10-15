import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key, required this.title});

  final String title;

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int _cumul = 0;
  int _increment = 2;
  int _counter = 0;
  var _operator = '*';
  final _operators = ['+', '-', '*', '/'];

  void _incrementCumul() {
    setState(() {
      _cumul++;
      _counter += _increment;
    });
  }

  void _updateIncrement(String value) {
    int? number = int.tryParse(value);

    if (number! < 1) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          title: Text('Erreur'),
          content: Text("L'incrément doit être supérieur à 0"),
        ),
      );
      setState(() {
        _increment = 2;
      });
    } else {
      setState(() {
        _increment = number;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: _operator,
              items: _operators.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _operator = value!;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(20),
                hintText: 'Incrément (= 2)',
              ),
              onChanged: _updateIncrement,
            ),
            Text(
              'Vous avez cliqué $_cumul fois',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_counter $_operator $_increment = ',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  '${switch (_operator) {
                    '+' => _counter + _increment,
                    '-' => _counter - _increment,
                    '*' => _counter * _increment,
                    '/' => _counter ~/ _increment,
                    _ => _counter,
                  }}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCumul,
        tooltip: 'Ajouter 2',
        child: Text('+$_increment'),
      ),
    );
  }
}
