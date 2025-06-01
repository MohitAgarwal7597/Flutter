void main() {
  final calculator = POMISCalculator(
    principal: 901000,
    isJointAccount: true,
    prematureWithdrawalYear: null, // or try 2 or 4
  );

  final result = calculator.calculate();
  print('--- POMIS Calculation ---');
  result.forEach((key, value) => print('$key: $value'));
}
class POMISCalculator {
  final double principal;
  final bool isJointAccount;
  final int? prematureWithdrawalYear;

  static const double annualInterestRate = 7.4;
  static const int maturityPeriodYears = 5;
  static const double minInvestment = 1000;
  static const double maxSingle = 900000;
  static const double maxJoint = 1500000;

  POMISCalculator({
    required this.principal,
    this.isJointAccount = true,
    this.prematureWithdrawalYear,
  }) {
    _validateInput();
  }

  void _validateInput() {
    final maxLimit = isJointAccount ? maxJoint : maxSingle;
    if (principal < minInvestment || principal % 1000 != 0) {
      throw ArgumentError('Amount should be ₹1000 or more, in multiples of ₹1000.');
    }
    if (principal > maxLimit) {
      throw ArgumentError('Amount exceeds maximum limit of ₹${maxLimit.toInt()} for ${isJointAccount ? "joint" : "single"} account.');
    }
    if (prematureWithdrawalYear != null) {
      if (prematureWithdrawalYear! < 1) {
        throw ArgumentError('Withdrawal not allowed before 1 year.');
      }
      if (prematureWithdrawalYear! > maturityPeriodYears) {
        throw ArgumentError('Cannot withdraw after full maturity.');
      }
    }
  }

  Map<String, String> calculate() {
    final monthlyInterest = (principal * (annualInterestRate / 100)) / 12;
    final totalMonths = maturityPeriodYears * 12;

    double totalInterest = monthlyInterest * totalMonths;
    double penalty = 0;
    double maturityAmount = principal + totalInterest;

    if (prematureWithdrawalYear != null) {
      final monthsInvested = prematureWithdrawalYear! * 12;
      totalInterest = monthlyInterest * monthsInvested;

      if (prematureWithdrawalYear! >= 1 && prematureWithdrawalYear! < 3) {
        penalty = 0.02 * principal;
      } else if (prematureWithdrawalYear! >= 3 && prematureWithdrawalYear! < 5) {
        penalty = 0.01 * principal;
      }

      maturityAmount = principal + totalInterest - penalty;
    }

    return {
      'Monthly Interest': '₹${monthlyInterest.toStringAsFixed(2)}',
      'Total Interest Earned': '₹${totalInterest.toStringAsFixed(2)}',
      'Penalty Deducted': '₹${penalty.toStringAsFixed(2)}',
      'Maturity Amount': '₹${maturityAmount.toStringAsFixed(2)}',
    };
  }
}
