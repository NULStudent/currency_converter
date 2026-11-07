import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget { // Coloured box that shows the result
  const ResultCard({super.key, required this.fromText, required this.amountText, required this.rateText});

  final String fromText; // What we are converting
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
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24), // Space inside the box
      decoration: BoxDecoration(
        gradient: LinearGradient( // Blends two theme colours
          colors: [theme.colorScheme.primary, theme.colorScheme.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24), // Rounded corners
        boxShadow: [
          BoxShadow( // Soft shadow under the box
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(fromText, style: style.copyWith(fontWeight: FontWeight.normal)), // What we are converting
          const SizedBox(height: 4), // Small gap
          FittedBox( // Shrinks very big numbers so they still fit
            fit: BoxFit.scaleDown,
            child: Text(
              amountText,
              style: style.copyWith(fontSize: theme.textTheme.displayMedium?.fontSize), // Big result text
            ),
          ),
          const SizedBox(height: 8), // Small gap
          Container( // Pill around the rate
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.15), // See-through white
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(rateText, style: style.copyWith(fontWeight: FontWeight.normal, fontSize: 14)), // Rate line
          ),
        ],
      ),
    );
  }
}