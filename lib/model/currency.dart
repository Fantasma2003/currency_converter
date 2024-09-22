import '../data/currency_data.dart';

class Currency {
  String flagCode;
  String key;

  Currency({
    required this.flagCode,
    required this.key,
  });

  factory Currency.fromJson(String key) {
    return Currency(
      flagCode: key.substring(0, 2),
      key: key,
    );
  }
}

List<Currency> currencyList = CurrencyData.currenciesData.entries.map((currency) {
  return Currency.fromJson(currency.key);
}).toList();
