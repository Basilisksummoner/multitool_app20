import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:multitool_app/shared/app_state.dart';
import './services/currency_service.dart';
import '../main.dart';


class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});
  
  @override
  State<CurrencyPage> createState() => CurrencyPageState();
}

class CurrencyPageState extends State<CurrencyPage> {
  
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrencies(setState);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar('Валютный калькулятор'),
      
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: const EdgeInsets.all(40),
                child: Lottie.asset('assets/currency.json',
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
                        if (value != ''){
                          setState(() {
                            double amount = double.parse(value);
                            CurrencyState().total = amount * CurrencyState().rate;
                          });
                        }
                      },
                ),
              ),
              Padding(padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 100,
                      child: DropdownButton<String>(
                        value: CurrencyState().fromCurrency,
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
                            CurrencyState().fromCurrency = newValue!;
                            getRates(setState);
                          });
                          getCurrencies(setState);
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
                        value: CurrencyState().toCurrency,
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
                            CurrencyState().toCurrency = newValue!;
                            getRates(setState);
                          });
                          getCurrencies(setState);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text('Курс: ${CurrencyState().rate}',
                style: TextStyle(
                  color: Colors.white, fontSize: 20
                )
              ),
              SizedBox(height: 40),
              Text(CurrencyState().total.toStringAsFixed(3),
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
  
  


             
               