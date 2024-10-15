import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Imc extends StatefulWidget {
  const Imc({super.key, required this.title});

  final String title;

  @override
  State<Imc> createState() => _ImcState();
}

class _ImcState extends State<Imc> {
  int _weight = 0;
  int _size = 0;

  double get _bmi {
    if (_size > 0) {
      double heightInMeters = _size / 100;
      return _weight / (heightInMeters * heightInMeters);
    }
    return 0;
  }

  void _updateWeight(String value) {
    int? number = int.tryParse(value);
    setState(() {
      _weight = number ?? 0;
    });
  }

  void _updateSize(String value) {
    int? number = int.tryParse(value);
    setState(() {
      _size = number ?? 0;
    });
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
            TextField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(20),
                hintText: 'Height (cm)',
              ),
              onChanged: _updateSize,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(20),
                hintText: 'Weight (kg)',
              ),
              onChanged: _updateWeight,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 50),
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 10,
                  maximum: 40,
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: 10,
                      endValue: 18.5,
                      color: Colors.blue,
                      label: 'Underweight',
                    ),
                    GaugeRange(
                      startValue: 18.5,
                      endValue: 24.9,
                      color: Colors.green,
                      label: 'Healthy',
                    ),
                    GaugeRange(
                      startValue: 25,
                      endValue: 29.9,
                      color: Colors.orange,
                      label: 'Overweight',
                    ),
                    GaugeRange(
                      startValue: 30,
                      endValue: 40,
                      color: Colors.red,
                      label: 'Obese',
                    ),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: _bmi,
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        _bmi.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      angle: 90,
                      positionFactor: 0.5,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
