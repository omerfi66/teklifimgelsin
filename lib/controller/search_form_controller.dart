import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

deneme({prefix = '', header = '', parameter = '', suffix = ''}) {
  return Column(
    children: [
      Text(header),
      Text(
        '$prefix$parameter$suffix',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  );
}

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

double calculatetotalCost(double monthlyPayment, int maturityController) {
  double totalCost = monthlyPayment * maturityController;
  return totalCost;
}
