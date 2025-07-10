import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:multitool_app/config/config.dart';
import 'dart:convert';


String fromCurrency = 'USD';
String toCurrency = 'KGS';
double rate = 0.0;
double total = 0.0;
TextEditingController amountController = TextEditingController();
List<String> currencies = [];

void getCurrencies(Function updateState) async{
  var response = await http.get(Uri.parse(Config.urlForCurr));

  if (response.statusCode == 200) {
    try {
      final data = json.decode(response.body);
    updateState(() {
      currencies = (data['conversion_rates'] as Map<String, dynamic>).keys.toList();
    });
    } catch (e) {
      print('Ошибка при разборе данных: $e');
      print('Ответ от сервера: ${response.body}');
    }

    getRates(updateState);
  
  } else {
    print('Ошибка загрузки данных: ${response.statusCode}');
    print('Ответ: ${response.body}');
  }
}
  
void getRates(Function updateState) async{
  
  var response = await http.get(Uri.parse(Config.urlForCurr));
    
    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        updateState(() {
          rate = (data['conversion_rates'][toCurrency] as num).toDouble();
        });
      } catch (e) {
      print('Ошибка при разборе данных: $e');
      print('Ответ от сервера: ${response.body}');
    }
  } else {
    print('Ошибка загрузки данных: ${response.statusCode}');
    print('Ответ: ${response.body}');
  }
}

void swapCurrencies(Function updateState) {
  String temp = fromCurrency;
  fromCurrency = toCurrency;
  toCurrency = temp;
  getRates(updateState);
}