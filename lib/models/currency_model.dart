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
}