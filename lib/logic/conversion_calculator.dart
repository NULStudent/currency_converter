import '../data/exchange_rates.dart';

class ConversionCalculator { // All the maths lives here, no widgets
  static double rate(String from, String to) { // How much 1 "from" is worth in "to"
    return exchangeRates[to]! / exchangeRates[from]!;
  }

  static double convert(double amount, String from, String to) { // Converts the amount
    return amount * rate(from, to);
  }

    static String formatAmount(double value, String code) { // Turns the result into text
    final decimals = code == 'JPY' ? 0 : 2; // Yen has no pennies
    final parts = value.toStringAsFixed(decimals).split('.'); // Splits whole and decimal parts
    final whole = parts[0].replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',', // Adds a comma every three digits
    );
    return parts.length > 1 ? '$whole.${parts[1]}' : whole;
  }

  static String formatRate(String from, String to) { // Text like "1 USD = 0.7900 GBP"
    return '1 $from = ${rate(from, to).toStringAsFixed(4)} $to';
  }
}