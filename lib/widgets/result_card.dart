import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget { // Coloured box that shows the result
  const ResultCard({super.key, required this.amountText, required this.rateText});

  final String amountText; // Converted amount 
  final String rateText; // Rate line

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context); // Saves the theme so we can reuse it
    final style = theme.textTheme.titleMedium!.copyWith( // Text style for the box
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );

    return Container(
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
            amountText,
            style: style.copyWith(fontSize: theme.textTheme.displaySmall?.fontSize), // Big result text
          ),
          Text(rateText, style: style.copyWith(fontWeight: FontWeight.normal)), // Rate line
        ],
      ),
    );
  }
}