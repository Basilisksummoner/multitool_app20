import 'package:http/http.dart' as http;
import 'package:multitool_app/config/config.dart';
import 'dart:convert';
import 'package:multitool_app/shared/app_state.dart';
import 'package:multitool_app/models/currency_model.dart';


final currency = CurrencyState.instance;
var currencies = CurrencyState.instance.currencies;

Future getCurrencies() async {
  var response = await http.get(Uri.parse(Config.urlForCurr('USD')));


  if (response.statusCode == 200) {
    try {
      final data = json.decode(response.body);
      currencies = (data['conversion_rates'] as Map<String, dynamic>).keys.toList();
    } catch (e) {
      print('Ошибка при разборе данных: $e');
      print('Ответ от сервера: ${response.body}');
    }

    await getRates();
  
  } else {
    print('Ошибка загрузки данных: ${response.statusCode}');
    print('Ответ: ${response.body}');
  }
}
  
Future getRates() async {
  
  var response = await http.get(Uri.parse(Config.urlForCurr(currency.fromCurrency)));
    
    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);

          currency.rate = (
            data['conversion_rates'][currency.toCurrency] as num
            ).toDouble();

      } catch (e) {
      print('Ошибка при разборе данных: $e');
      print('Ответ от сервера: ${response.body}');
    }
  } else {
    print('Ошибка загрузки данных: ${response.statusCode}');
    print('Ответ: ${response.body}');
  }
}

Future swapCurrencies() async {
  final temp = currency.fromCurrency;
  await currency.updateCurrency(
    from: currency.toCurrency,
    to: temp,
  );
}


/*Future getCurrencies() async {
  
  final response = await http.get(Uri.parse(Config.urlForCurr(currency.fromCurrency)));
  
  if (response.statusCode == 200) {
    try {
      
      final data = json.decode(response.body);

      currency.allCurrencies = Currency.fromJson(data);

      final rate = (data['conversion_rates'][currency.toCurrency] as num).toDouble();
      currency.conversionRate = rate;
      } catch (e) {
          print('Ошибка при разборе данных: $e');
          print('Ответ от сервера: ${response.body}');}
  }
}*/