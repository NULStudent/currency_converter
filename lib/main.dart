import 'package:flutter/material.dart';
import 'data/exchange_rates.dart'; // Rates, names and symbols
import 'logic/conversion_calculator.dart'; // The conversion maths
import 'widgets/amount_field.dart'; // Amount input
import 'widgets/currency_selector.dart'; // Currency dropdown
import 'widgets/result_card.dart'; // Result box

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

  void _swapCurrencies() { // Swaps From and To
    setState(() {
      final temp = _fromCurrency; // Keeps the old From for a moment
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context); // Saves the theme so we can reuse it
    final result = ConversionCalculator.convert(_amount, _fromCurrency, _toCurrency); // Works out the result

    return Scaffold( // Basic screen layout
      appBar: AppBar(title: const Text('Currency Converter')), // Top bar with the title
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Makes boxes fill the width
        children: [
          ResultCard( // Result box at the top
            amountText: '${currencySymbols[_toCurrency]}${ConversionCalculator.formatAmount(result, _toCurrency)}',
            rateText: ConversionCalculator.formatRate(_fromCurrency, _toCurrency),
          ),
          Container( // Input box
            margin: const EdgeInsets.symmetric(horizontal: 16), // Space on the sides
            padding: const EdgeInsets.all(16), // Space inside the box
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), // Rounded corners
              border: Border.all(color: theme.colorScheme.primary, width: 2), // Outline in the theme colour
            ),
            child: Column(
              children: [
                AmountField( // Amount input
                  onChanged: (value) {
                    setState(() {
                      _amount = double.tryParse(value) ?? 0; // Empty or wrong input becomes 0
                    });
                  },
                ),
                const SizedBox(height: 16), // Gap under the amount field
                Row( // From, swap and To side by side
                  children: [
                    Expanded(
                      child: CurrencySelector( // From dropdown
                        label: 'From',
                        value: _fromCurrency,
                        onChanged: (code) {
                          setState(() {
                            _fromCurrency = code;
                          });
                        },
                      ),
                    ),
                    IconButton( // Swap button
                      icon: const Icon(Icons.swap_horiz),
                      color: theme.colorScheme.primary,
                      tooltip: 'Swap currencies', // Text shown on long press
                      onPressed: _swapCurrencies,
                    ),
                    Expanded(
                      child: CurrencySelector( // To dropdown, same widget reused
                        label: 'To',
                        value: _toCurrency,
                        onChanged: (code) {
                          setState(() {
                            _toCurrency = code;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}