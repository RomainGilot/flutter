import 'package:flutter/material.dart';

class PommePoireAnanas extends StatefulWidget {
  const PommePoireAnanas({super.key, required this.title});

  final String title;

  @override
  State<PommePoireAnanas> createState() => _PommePoireAnanasState();
}

class _PommePoireAnanasState extends State<PommePoireAnanas> {
  int _counter = 1;
  final List<int> _fruits = [];

  bool _isPrime(int number) {
    if (number < 2) return false;
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  void _addItem() {
    setState(() {
      _fruits.add(_counter);
      _counter++;
    });
  }

  void _removeItem(int value) {
    setState(() {
      _fruits.remove(value);
    });
  }

  Color _getFabColor() {
    if (_counter == 1) {
      return Colors.orange;
    } else if (_counter % 2 == 0) {
      return Colors.indigo;
    } else {
      return Colors.cyan;
    }
  }

  Color _getBackgroundColor(int value) {
    return value % 2 == 0 ? Colors.indigo : Colors.cyan;
  }

  Widget _getImage(int value) {
    if (_isPrime(value)) {
      return Image.asset('images/ananas.png', width: 30, height: 30);
    }

    switch (value % 2) {
      case 0:
        return Image.asset('images/poire.png', width: 30, height: 30);
      case 1:
      default:
        return Image.asset('images/pomme.png', width: 30, height: 30);
    }
  }

  String _getCounterType(int value) {
    if (_isPrime(value)) {
      return 'nombre premier';
    }

    switch (value % 2) {
      case 0:
        return 'pair';
      case 1:
      default:
        return 'impair';
    }
  }

  void _showItemDialog(BuildContext context, int value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: _getBackgroundColor(value),
          title: Text('Le nombre $value est ${_getCounterType(value)}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getImage(value),
              const SizedBox(height: 10),
              Text('Valeur : $value'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _removeItem(value);
                Navigator.of(context).pop();
              },
              child: const Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${_counter - 1} ${_getCounterType(_counter - 1)}',
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _fruits.length,
          itemBuilder: (context, index) {
            final value = _fruits[index];
            final backgroundColor = _getBackgroundColor(value);

            return Container(
              color: backgroundColor,
              child: ListTile(
                leading: _getImage(value),
                title: Text(
                  '$value',
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () => _showItemDialog(context, value),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Ajouter un item',
        backgroundColor: _getFabColor(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
