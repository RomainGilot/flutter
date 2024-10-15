import 'package:flutter/material.dart';
import 'package:pomme_poire_ananas/pommePoireAnanas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PommePoireAnanas(title: 'Calculator'),
    );
  }
}
