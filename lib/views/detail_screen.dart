import 'package:flutter/material.dart';
import 'package:teklifimgelsin/model/color.dart';
import 'package:teklifimgelsin/model/loan_offer.dart';

class LoanDetailsPopup extends StatelessWidget {
  final LoanOffer loanOffer;

  const LoanDetailsPopup({Key? key, required this.loanOffer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      contentPadding: EdgeInsets.zero,
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width *
            0.95, // Ekran genişliğinin %90'ı kadar olacak şekilde ayarlayabilirsiniz
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
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
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Bank: ${loanOffer.bank}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text('Interest Rate: ${loanOffer.interestRate}%'),
                        Text('Annual Rate: ${loanOffer.annualRate}'),
                        Text('Bank Type: ${loanOffer.bankType}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        minimumSize: const Size(double.infinity, 44),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
