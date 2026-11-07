import 'package:flutter_test/flutter_test.dart';
import 'package:currency_converter/logic/conversion_calculator.dart';

void main() {
  test('100 USD to GBP gives 79.00', () { // Worked example from the brief
    final result = ConversionCalculator.convert(100, 'USD', 'GBP');
    expect(ConversionCalculator.formatAmount(result, 'GBP'), '79.00');
  });

  test('200 USD to GBP gives 158.00', () { // Worked example from the brief
    final result = ConversionCalculator.convert(200, 'USD', 'GBP');
    expect(ConversionCalculator.formatAmount(result, 'GBP'), '158.00');
  });

  test('100 GBP to USD gives 126.58', () { // Swapped example
    final result = ConversionCalculator.convert(100, 'GBP', 'USD');
    expect(ConversionCalculator.formatAmount(result, 'USD'), '126.58');
  });

  test('Same currency has a rate of 1', () { // Edge case
    expect(ConversionCalculator.rate('EUR', 'EUR'), 1.0);
  });

  test('Zero amount gives zero', () { // Edge case
    expect(ConversionCalculator.convert(0, 'USD', 'NGN'), 0);
  });

  test('Rate text is shown correctly', () { // Checks the rate label
    expect(ConversionCalculator.formatRate('USD', 'GBP'), '1 USD = 0.7900 GBP');
  });

  test('Yen is shown with no decimals', () { // Edge case
    expect(ConversionCalculator.formatAmount(150, 'JPY'), '150');
  });
}