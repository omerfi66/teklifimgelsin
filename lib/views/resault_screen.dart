import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teklifimgelsin/model/color.dart';
import 'package:teklifimgelsin/model/loan_offer.dart';
import 'package:teklifimgelsin/views/detail_screen.dart';

class LoanListPage extends StatelessWidget {
  final List<LoanOffer> loanOffers;

  final TextEditingController amountController;
  final TextEditingController maturityController;

  const LoanListPage({
    Key? key,
    required this.loanOffers,
    required this.amountController,
    required this.maturityController,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Kredi Teklifleri'),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: ListView.builder(
        itemCount: loanOffers.length,
        itemBuilder: (context, index) {
          final loanOffer = loanOffers[index];
          return Card(
            color: AppColors.whiteColor,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(
                color: Colors.grey, // Border rengini kırmızı yapar
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            loanOffer.bank,
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.check_circle_outlined,
                                  color: Colors.green,
                                ),
                                Text(
                                  'Reklam',
                                  style: TextStyle(color: Colors.green),
                                )
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                _showDetailsPopup(context, loanOffer);
                              },
                              child: const Text(
                                'Detaylar >',
                                style:
                                    TextStyle(color: AppColors.optionalColor),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text('Aylık Taksit'),
                          Text(
                            '₺${formatMonthly(calculateMonthlyPayment(double.parse(amountController.text), loanOffer.interestRate * 0.013, int.parse(maturityController.text)).toStringAsFixed(2))}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          const Text('Faiz Oranı'),
                          Text(
                            '${loanOffer.interestRate}%',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      //Text('Toplam Tutar  \n    ₺${amountController.text}*'),
                      Column(
                        children: [
                          const Text('Toplam Tutar'),
                          Text(
                            '₺${formatAmount(amountController.text)}*',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _applyForLoan(context, loanOffer);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        minimumSize: const Size(double.infinity, 48),
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.open_in_new,
                            color: AppColors.whiteColor,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Hemen Başvur !',
                            style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDetailsPopup(
    BuildContext context,
    LoanOffer loanOffer,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoanDetailsPopup(
          loanOffer: loanOffer,
        );
      },
    );
  }

  void _applyForLoan(BuildContext context, LoanOffer loanOffer) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Başvuru yapıldı: ${loanOffer.bank}')),
    );
  }
}
