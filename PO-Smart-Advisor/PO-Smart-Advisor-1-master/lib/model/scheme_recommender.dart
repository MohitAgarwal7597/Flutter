import 'dart:math';

class Scheme {
  final String name;
  final double minAmount;
  final int lockinMonths;
  final double interestRate; // annual
  final Compounding compounding;
  final String notes;

  Scheme({
    required this.name,
    required this.minAmount,
    required this.lockinMonths,
    required this.interestRate,
    required this.compounding,
    required this.notes,
  });

  double calculateMaturity(double amount, int periodInMonths) {
    if (amount < minAmount || periodInMonths < lockinMonths) return 0;
    double years = periodInMonths / 12;
    int n; // frequency of compounding
    switch (compounding) {
      case Compounding.annually:
        n = 1;
        break;
      case Compounding.quarterly:
        n = 4;
        break;
      case Compounding.monthly:
        n = 12;
        break;
      case Compounding.none:
        return amount + (amount * interestRate * years / 100);
    }
    return amount * pow(1 + (interestRate / (n * 100)), n * years);
  }
}

enum Compounding { annually, quarterly, monthly, none }

class SchemeRecommender {
  final List<Scheme> schemes = [
    Scheme(
        name: 'KVP',
        minAmount: 1000,
        lockinMonths: 30,
        interestRate: 7.5,
        compounding: Compounding.annually,
        notes: 'Maturity in 115 months'),
    Scheme(
        name: 'RD',
        minAmount: 100,
        lockinMonths: 60,
        interestRate: 6.7,
        compounding: Compounding.quarterly,
        notes: '5Y Recurring Deposit'),
    Scheme(
        name: 'TD 1Y',
        minAmount: 1000,
        lockinMonths: 12,
        interestRate: 6.9,
        compounding: Compounding.quarterly,
        notes: '1 Year Time Deposit'),
    Scheme(
        name: 'TD 2Y',
        minAmount: 1000,
        lockinMonths: 24,
        interestRate: 7.0,
        compounding: Compounding.quarterly,
        notes: '2 Year Time Deposit'),
    Scheme(
        name: 'TD 3Y',
        minAmount: 1000,
        lockinMonths: 36,
        interestRate: 7.1,
        compounding: Compounding.quarterly,
        notes: '3 Year Time Deposit'),
    Scheme(
        name: 'TD 5Y',
        minAmount: 1000,
        lockinMonths: 60,
        interestRate: 7.5,
        compounding: Compounding.quarterly,
        notes: '5 Year Time Deposit'),
    Scheme(
        name: 'MIS',
        minAmount: 1000,
        lockinMonths: 60,
        interestRate: 7.4,
        compounding: Compounding.none,
        notes: 'Monthly Income Scheme'),
    Scheme(
        name: 'NSC',
        minAmount: 1000,
        lockinMonths: 60,
        interestRate: 7.7,
        compounding: Compounding.annually,
        notes: 'National Savings Certificate'),
    Scheme(
        name: 'PPF',
        minAmount: 500,
        lockinMonths: 180,
        interestRate: 7.1,
        compounding: Compounding.annually,
        notes: 'Public Provident Fund'),
    Scheme(
        name: 'SSY',
        minAmount: 250,
        lockinMonths: 168,
        interestRate: 8.2,
        compounding: Compounding.annually,
        notes: 'Sukanya Samriddhi Yojana'),
    Scheme(
        name: 'SCSS',
        minAmount: 1000,
        lockinMonths: 60,
        interestRate: 8.2,
        compounding: Compounding.quarterly,
        notes: 'Senior Citizen Saving Scheme'),
    Scheme(
        name: 'SB',
        minAmount: 50,
        lockinMonths: 0,
        interestRate: 4.0,
        compounding: Compounding.none,
        notes: 'Savings Bank'),
  ];

  Scheme? recommendBestScheme(double amount, int periodInMonths) {
    List<Map<String, dynamic>> results = schemes.map((scheme) {
      double maturity = scheme.calculateMaturity(amount, periodInMonths);
      return {'scheme': scheme, 'maturity': maturity};
    }).toList();

    results.removeWhere((entry) => entry['maturity'] == 0);

    results.sort((a, b) => (b['maturity'] as double).compareTo(a['maturity'] as double));

    return results.isNotEmpty ? results.first['scheme'] as Scheme : null;
  }

  double? bestReturnAmount(double amount, int periodInMonths) {
    Scheme? best = recommendBestScheme(amount, periodInMonths);
    return best?.calculateMaturity(amount, periodInMonths);
  }
}
