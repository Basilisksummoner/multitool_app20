import 'package:http/http.dart' as http;
import 'package:multitool_app/cache.dart';
import 'package:multitool_app/config/config.dart';
import 'package:multitool_app/models/currency_model.dart';
import 'dart:convert';
import 'package:multitool_app/shared/app_state.dart';


final currency = CurrencyState.instance;
//var currencies = CurrencyState.instance.currenciesList;

/*Future getCurrencies() async {
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
}*/

Future swapCurrencies() async {

  final temp = currency.fromCurrency;
  await currency.updateCurrency(
    from: currency.toCurrency,
    to: temp,
  );
}


Future<void> getCurrencies() async {
  try {
    final url = Config.urlForCurr(currency.fromCurrency);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      
      final parsed = Currency.fromJson(data);
      currency.currenciesList = parsed;

     
      await saveToCache('cached_currencies', Currency.toJsonList(parsed));


      final rate = parsed.firstWhere(
        (c) => c.name == currency.toCurrency,
        orElse: () => Currency(name: '', rate: 0.0),
      ).rate;

      currency.rate = rate;
    } else {
      throw Exception('Ошибка HTTP: ${response.statusCode}');
    }
  } catch (e) {
    print('Ошибка при получении валют: $e');


    final cached = await readCache('cached_currencies');
    if (cached != null && cached is List) {
      final parsed = Currency.fromJsonList(cached);
      currency.currenciesList = parsed;

      final rate = parsed.firstWhere(
        (c) => c.name == currency.toCurrency,
        orElse: () => Currency(name: '', rate: 0.0),
      ).rate;

      currency.rate = rate;
    }
  }
}