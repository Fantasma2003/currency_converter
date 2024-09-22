import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConverterRepo {
  final baseUrl = 'https://api.getgeoapi.com/v2/currency/convert';
  final apiKey = '?api_key=356bf2ce686c10f00409e858be9cc22a47f0eb37';

  Future<double> getRateForAmount({
    required String firstCountry,
    required String secondCountry,
    required double amount,
  }) async {
    double rateForAmount = 0;

    final url = Uri.parse('$baseUrl$apiKey&from=$firstCountry&to=$secondCountry&amount=$amount');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final rates = jsonData['rates'];
        rateForAmount = double.parse(rates[secondCountry]["rate_for_amount"]);
      }
    } catch (e) {
      throw Exception(e);
    }

    return rateForAmount;
  }
}
