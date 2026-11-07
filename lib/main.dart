import 'package:flutter/material.dart';
import 'data/exchange_rates.dart'; // Rates, names and symbols
import 'logic/conversion_calculator.dart'; // The conversion maths
import 'package:flutter/services.dart'; // Lets us control what can be typed

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
          Container( // Input box
            margin: const EdgeInsets.symmetric(horizontal: 16), // Space on the sides
            padding: const EdgeInsets.all(16), // Space inside the box
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), // Rounded corners
              border: Border.all(color: theme.colorScheme.primary, width: 2), // Outline in the theme colour
            ),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(), // Box around the field
                    labelText: 'Enter amount', // Label inside the field
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true), // Number keyboard with a dot
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')), // Digits, one dot, two decimals
                  ],
                  onChanged: (String value) { // Runs on every key press
                    setState(() {
                      _amount = double.tryParse(value) ?? 0; // Empty or wrong input becomes 0
                    });
                  },
                ),
                const SizedBox(height: 16), // Gap under the amount field
                Row( // From, swap and To side by side
                  children: [
                    Expanded( // From dropdown takes half the space
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'From', // Label on the border
                          border: OutlineInputBorder(),
                        ),
                        child: DropdownButtonHideUnderline( // Removes the default line
                          child: DropdownButton<String>(
                            value: _fromCurrency, // Currently selected currency
                            isExpanded: true, // Fills the box
                            isDense: true, // Keeps it compact
                            items: exchangeRates.keys.map((code) {
                              return DropdownMenuItem(
                                value: code,
                                child: Text('$code  ${currencyNames[code]}', overflow: TextOverflow.ellipsis), // Code and name
                              );
                            }).toList(),
                            onChanged: (String? value) { // Runs when a new currency is picked
                              setState(() {
                                _fromCurrency = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    IconButton( // Swap button
                      icon: const Icon(Icons.swap_horiz),
                      color: theme.colorScheme.primary,
                      tooltip: 'Swap currencies', // Text shown on long press
                      onPressed: _swapCurrencies,
                    ),
                    Expanded( // To dropdown takes the other half
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'To', // Label on the border
                          border: OutlineInputBorder(),
                        ),
                        child: DropdownButtonHideUnderline( // Removes the default line
                          child: DropdownButton<String>(
                            value: _toCurrency, // Currently selected currency
                            isExpanded: true, // Fills the box
                            isDense: true, // Keeps it compact
                            items: exchangeRates.keys.map((code) {
                              return DropdownMenuItem(
                                value: code,
                                child: Text('$code  ${currencyNames[code]}', overflow: TextOverflow.ellipsis), // Code and name
                              );
                            }).toList(),
                            onChanged: (String? value) { // Runs when a new currency is picked
                              setState(() {
                                _toCurrency = value!;
                              });
                            },
                          ),
                        ),
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