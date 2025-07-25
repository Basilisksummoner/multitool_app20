**Временные notes для фикса `setState` в `getCurrencies()`**

1) Что именно делает функция?

    `awaitит` URL с currency сайта через переменную `response`
    Если респонс == 200 делает `try{ }`: через final переменную 
    `data` json декодит `(response.body)`.  Присваивает переменной 
    `currencies` - ['conversion_rates'] из перменной `data` как мапа
    Зачем-то инициализирует `getRates()`
    Else выводит "Ошибка загрузки данных"
   
    Функция ничего не возвращает

2) Где используются данные из функции

    Use cases:
    1. `currencies` - была создана глобальная перменная 
        List<String> currencies = [];
        
        Используется в *currency_page* в *DropdownButtonе*
        item: currencies.map(String value)
        Таких кнопок две


    Доп. - `final currency = CurrencyState.instance;`
    Есть также функция getRates();
    там используется `currency.rate`

3) Источник состояния - в AppState 
    CurrencyState{} - синглтон класс


Что было сделано?
`getCurrencies` возвращал void, сделан Future (чтобы awaitить его)
и остальные `getRates`, `swapCurrencies`

`setState()` вызывается теперь только в UI когда его нужно перерисовать

переделал на Future пмтчто мои функции awaitят чето и по факту являются asincами. Если оставить void то код не будет ждать,
а с awaitом код будет выполняться последовательно

onChanged тоже стал async чтобы awaitить и чтобы не было такого что
user нажал на кнопку ничего не загрузилось но UI отрисовлся

