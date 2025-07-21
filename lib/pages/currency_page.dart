import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:multitool_app/shared/app_state.dart';
import '../api_methods/currency_method.dart';
import '../main_scaffold.dart';
import '../text_styles.dart';


class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});
  
  @override
  State<CurrencyPage> createState() => CurrencyPageState();
}

class CurrencyPageState extends State<CurrencyPage> {
  final currency = CurrencyState.instance;

  
  TextEditingController amountController = TextEditingController();
  
  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Валютный калькулятор',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: const EdgeInsets.all(40),
                child: Lottie.asset('assets/currency/currency.json',
                width: MediaQuery.of(context).size.width / 2,)
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Введите сумму',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.white
                        ),
                      )),
                      onChanged: (value){
                        setState(() {
                          if (value.isEmpty){
                            currency.total = 0.0;
                          } else {
                            double amount = double.tryParse(value) ?? 0.0;
                            currency.total = amount * currency.rate;
                            }
                        });  
                      },
                ),
              ),
              Padding(padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 100,
                      child: DropdownButton<String>(
                        value: currency.fromCurrency,
                        isExpanded: true,
                        dropdownColor: Colors.black,
                        style: TextStyle(color: Colors.white),
                        items: currencies.map((String value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value)
                          );
                        }).toList(),
                        onChanged: (newValue){
                          setState(() {
                            currency.fromCurrency = newValue!;
                            getRates();
                          });
                          getCurrencies();
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () => swapCurrencies(setState),
                      icon: Icon(Icons.swap_horiz,
                      size: 40, 
                      color: Colors.white),
                    ),
                    SizedBox(width: 100,
                      child: DropdownButton<String>(
                        value: currency.toCurrency,
                        isExpanded: true,
                        dropdownColor: Colors.black,
                        style: TextStyle(color: Colors.white),
                        items: currencies.map((String value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value)
                          );
                        }).toList(),
                        onChanged: (newValue){
                          setState(() {
                            currency.toCurrency = newValue!;
                            getRates();
                          });
                          getCurrencies();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text('Курс: ${currency.rate}',
                style: TextStyles.size(20, FontWeight.w400)
                ),
              SizedBox(height: 40),
              Text(currency.total.toStringAsFixed(3),
                style: TextStyle(
                  color: const Color.fromARGB(255, 173, 129, 217),
                  fontSize: 40,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}              