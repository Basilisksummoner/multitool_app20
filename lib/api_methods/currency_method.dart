import 'package:http/http.dart' as http;
import 'package:multitool_app/config/config.dart';
import 'dart:convert';
import 'package:multitool_app/shared/app_state.dart';


List<String> currencies = [];
final currency = CurrencyState.instance;

void getCurrencies(Function updateState) async{
  var response = await http.get(Uri.parse(Config.urlForCurr('USD')));


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
  
  var response = await http.get(Uri.parse(Config.urlForCurr(currency.fromCurrency)));
    
    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        updateState(() {
          currency.rate = (
            data['conversion_rates'][currency.toCurrency] as num
            ).toDouble();
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
  String temp = currency.fromCurrency;
  currency.fromCurrency = currency.toCurrency;
  currency.toCurrency = temp;
  getRates(updateState);
}