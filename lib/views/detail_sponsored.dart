import 'package:flutter/material.dart';
import 'package:teklifimgelsin/model/color.dart';
import 'package:teklifimgelsin/model/loan_offer.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsoredDetailsPopup extends StatelessWidget {
  final SponsoredOffers sponsoredOffer;

  const SponsoredDetailsPopup({
    Key? key,
    required this.sponsoredOffer,
  }) : super(key: key);

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
                              sponsoredOffer.bank ?? '',
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
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       //   Text('Faiz oranı: ${loanOffer.interestRate}%'),

                  //       yazi('Faiz oranı:  ', '${loanOffer.interestRate}%'),

                  //       yazi('Yıllık gider oranı: ', '${loanOffer.annualRate}'),
                  //       yazi('Kredi tutari: ',
                  //           '${formatAmount(amountControllerA.text)} ₺'),
                  //       yazi('Vade Sayısı: ',
                  //           formatAmount(maturityControllerA.text)),
                  //     ],
                  //   ),
                  // ),
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
                        //Navigator.of(context).pop();
                        _launchURL(sponsoredOffer.adUtmLink!);
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

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'URL açılamadı: $url';
    }
  }
}

yazi(text, parametre) {
  return Row(
    children: [
      Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(parametre)
    ],
  );
}
