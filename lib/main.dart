import 'package:flutter/material.dart';
import 'data/exchange_rates.dart'; // Rates, names and symbols
import 'logic/conversion_calculator.dart'; // The conversion maths

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
  double _amount = 0; // Amount typed by the user
  String _fromCurrency = 'USD'; // Currency we convert from
  String _toCurrency = 'GBP'; // Currency we convert to

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context); // Saves the theme so we can reuse it
    final style = theme.textTheme.titleMedium!.copyWith( // Text style for the result box
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );
    final result = ConversionCalculator.convert(_amount, _fromCurrency, _toCurrency); // Works out the result

    return Scaffold( // Basic screen layout
      appBar: AppBar(title: const Text('Currency Converter')), // Top bar with the title
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Makes boxes fill the width
        children: [
          Container( // Result box at the top
            margin: const EdgeInsets.all(16), // Space around the box
            padding: const EdgeInsets.all(24), // Space inside the box
            decoration: BoxDecoration(
              color: theme.colorScheme.primary, // Main theme colour
              borderRadius: BorderRadius.circular(16), // Rounded corners
            ),
            child: Column(
              children: [
                Text('Converted amount', style: style), // Label
                Text(
                  '${currencySymbols[_toCurrency]}${ConversionCalculator.formatAmount(result, _toCurrency)}',
                  style: style.copyWith(fontSize: theme.textTheme.displaySmall?.fontSize), // Big result text
                ),
                Text(
                  ConversionCalculator.formatRate(_fromCurrency, _toCurrency), // Shows "1 USD = 0.7900 GBP"
                  style: style.copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}