// Fixed rates, not live data. Each value is how much 1 USD is worth.
const Map<String, double> exchangeRates = {
  'USD': 1.0, // US Dollar (base currency)
  'GBP': 0.79, // British Pound
  'EUR': 0.92, // Euro
  'JPY': 150.0, // Japanese Yen
  'NGN': 1550.0, // Nigerian Naira
  'CAD': 1.37, // Canadian Dollar
};

const Map<String, String> currencyNames = { // Full names shown in the dropdowns
  'USD': 'US Dollar',
  'GBP': 'British Pound',
  'EUR': 'Euro',
  'JPY': 'Japanese Yen',
  'NGN': 'Nigerian Naira',
  'CAD': 'Canadian Dollar',
};

const Map<String, String> currencySymbols = { // Symbol shown before the result
  'USD': '\$',
  'GBP': '£',
  'EUR': '€',
  'JPY': '¥',
  'NGN': '₦',
  'CAD': 'C\$',
};