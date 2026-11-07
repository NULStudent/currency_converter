import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Lets us control what can be typed

class AmountField extends StatelessWidget { // Text field for the amount
  const AmountField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged; // Sends the new text back to the screen

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Enter amount', // Label inside the field
        prefixIcon: Icon(Icons.payments_outlined), // Money icon at the start
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true), // Number keyboard with a dot
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d{0,12}\.?\d{0,2}')), // Up to 12 digits, two decimals
      ],
      onChanged: onChanged, // Runs on every key press
    );
  }
}