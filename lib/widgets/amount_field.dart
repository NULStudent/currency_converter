import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Lets us control what can be typed

class AmountField extends StatelessWidget { // Text field for the amount
  const AmountField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged; // Sends the new text back to the screen

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(), // Box around the field
        labelText: 'Enter amount', // Label inside the field
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true), // Number keyboard with a dot
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')), // Digits, one dot, two decimals
      ],
      onChanged: onChanged, // Runs on every key press
    );
  }
}