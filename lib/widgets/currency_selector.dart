import 'package:flutter/material.dart';
import '../data/exchange_rates.dart'; // List of currencies and names

class CurrencySelector extends StatelessWidget { // Dropdown to pick a currency
  const CurrencySelector({super.key, required this.label, required this.value, required this.onChanged});

  final String label; // "From" or "To"
  final String value; // Currency picked right now
  final ValueChanged<String> onChanged; // Sends the new currency back to the screen

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label, // Label on the border
        border: const OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline( // Removes the default line
        child: DropdownButton<String>(
          value: value,
          isExpanded: true, // Fills the box
          isDense: true, // Keeps it compact
          items: exchangeRates.keys.map((code) {
            return DropdownMenuItem(
              value: code,
              child: Text('$code  ${currencyNames[code]}', overflow: TextOverflow.ellipsis), // Code and name
            );
          }).toList(),
          onChanged: (String? code) {
            if (code != null) onChanged(code); // Only sends a real value
          },
        ),
      ),
    );
  }
}