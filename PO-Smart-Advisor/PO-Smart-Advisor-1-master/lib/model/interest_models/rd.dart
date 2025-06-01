class RD {
  double totalAmount = 0;
  double interestAmount = 0;
  double depositeAmount = 0;
  double calculateRDInterest(double deposits, double interestRate) {
    for (int i = 1; i <= 5; i++) {
      depositeAmount = deposits * 12;
      interestAmount = ((depositeAmount) * interestRate) / 100;
      depositeAmount += interestAmount;
    }
    return depositeAmount;
  }
}
