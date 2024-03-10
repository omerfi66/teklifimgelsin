import 'dart:math';

import 'package:intl/intl.dart';

String formatAmount(String amountText) {
  double amount = double.tryParse(amountText) ?? 0.0;
  final formatter = NumberFormat("#,##0", "tr_TR");
  return formatter.format(amount);
}

String formatMonthly(String amountText) {
  double amount = double.tryParse(amountText) ?? 0.0;
  final formatter = NumberFormat("#,##0.00", "tr_TR");
  return formatter.format(amount);
}

double calculateMonthlyPayment(
    double amount, double totalInterestRate, int maturityController) {
  double monthlyPayment = (amount *
          totalInterestRate *
          pow(1 + totalInterestRate, maturityController)) /
      (pow(1 + totalInterestRate, maturityController) - 1);
  return monthlyPayment;
}

double calculateTotalCost(double monthlyPayment, int maturityController) {
  double totalCost = monthlyPayment * maturityController;
  return totalCost;
}
