import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // Starts the app
}

class MyApp extends StatelessWidget { // Root of the app, never changes
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      debugShowCheckedModeBanner: false, // Hides the DEBUG banner
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)), // Builds colours from indigo
      home: const CurrencyConverter(), // First screen to show
    );
  }
}

class CurrencyConverter extends StatefulWidget { // Main screen, its values can change
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState(); // Links the screen to its state
}

class _CurrencyConverterState extends State<CurrencyConverter> { // Holds the values that change
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Basic screen layout
      appBar: AppBar(title: const Text('Currency Converter')), // Top bar with the title
    );
  }
}