/*class Currency {
  final String name;
  final double rate;

  Currency({
    required this.name, 
    required this.rate,
  });

  static List<Currency> fromJson(Map<String, dynamic> json) {
    final rates = json['conversion_rates'] as Map<String, dynamic>;

    return rates.entries.map((entry) {
      return Currency(
        name: entry.key,
        rate: (entry.value as num).toDouble(),
      );
    }).toList();
  }
}*/


class Currency {
  final String name;
  final double rate;

  Currency({
    required this.name,
    required this.rate,
  });

  static List<Currency> fromJson(Map<String, dynamic> json) {
    final rates = json['conversion_rates'] as Map<String, dynamic>;
    return rates.entries.map((entry) {
      return Currency(
        name: entry.key,
        rate: (entry.value as num).toDouble(),
      );
    }).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<Currency> list) {
    return list.map((e) => {'name': e.name, 'rate': e.rate}).toList();
  }

  static List<Currency> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((item) => Currency(
              name: item['name'],
              rate: (item['rate'] as num).toDouble(),
            ))
        .toList();
  }
}