import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:teklifimgelsin/controller/search_form_controller.dart';
import 'package:teklifimgelsin/model/color.dart';
import 'package:teklifimgelsin/model/loan_offer.dart';
import 'package:teklifimgelsin/views/detail_screen.dart';
import 'package:teklifimgelsin/views/detail_sponsored.dart';
import 'package:url_launcher/url_launcher.dart';

class LoanListPage extends StatelessWidget {
  final LoanOffer loanOffers;
  final TextEditingController amountController;
  final TextEditingController maturityController;

  const LoanListPage({
    Key? key,
    required this.loanOffers,
    required this.amountController,
    required this.maturityController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Kredi Teklifleri'),
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: GroupedListView<dynamic, String>(
        elements: [
          ...loanOffers.sponsoredOffers ?? [],
          ...loanOffers.activeOffers ?? [],
        ],
        groupBy: (element) {
          if (element is SponsoredOffers) {
            return 'Sponsored Offers';
          } else if (element is ActiveOffers) {
            return 'Active Offers';
          }
          return '';
        },
        itemBuilder: (context, dynamic element) {
          if (element is SponsoredOffers) {
            return _buildCard2(context, element);
          } else if (element is ActiveOffers) {
            return _buildCard(context, element);
          }
          return Container();
        },
        groupSeparatorBuilder: (String groupByValue) {
          return groupByValue == 'Active Offers'
              ? const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Divider(
                    thickness: 5,
                  ),
                )
              : Container();
        },
        order: GroupedListOrder.DESC,
      ),
    );
  }

  Widget _buildCard(BuildContext context, dynamic offer) {
    return Card(
      color: AppColors.whiteColor,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(
          color: Colors.grey,
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
                      offer.bank ?? '',
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          if (offer is ActiveOffers) {
                            _showDetailsPopup(context, offer);
                          }
                        },
                        child: const Text(
                          'Detaylar >',
                          style: TextStyle(color: AppColors.optionalColor),
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
                deneme(
                  prefix: '₺',
                  header: 'Taksit',
                  parameter: formatMonthly(calculateMonthlyPayment(
                          double.parse(amountController.text),
                          offer.interestRate! * 0.013,
                          int.parse(maturityController.text))
                      .toStringAsFixed(2)),
                ),
                deneme(
                  suffix: '%',
                  header: 'ⓘ Oran',
                  parameter: offer.interestRate,
                ),
                deneme(
                  prefix: '₺',
                  header: 'Toplam Maliyet',
                  parameter: formatMonthly(calculateTotalCost(
                    calculateMonthlyPayment(
                        double.parse(amountController.text),
                        offer.interestRate! * 0.013,
                        int.parse(maturityController.text)),
                    int.parse(maturityController.text),
                  ).toStringAsFixed(2)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (offer is ActiveOffers) {
                    launchURL(offer.url!);
                  }
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
  }

  Widget _buildCard2(BuildContext context, dynamic offer) {
    return Card(
      color: AppColors.whiteColor,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(
          color: Colors.grey,
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
                      offer.bank ?? '',
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
                            'Reklam |',
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          if (offer is SponsoredOffers) {
                            _showSponsoredDetailsPopup(context, offer);
                          }
                        },
                        child: const Text(
                          'Detaylar >',
                          style: TextStyle(color: AppColors.optionalColor),
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
                deneme(
                  prefix: '₺',
                  header: 'Aylık Taksit',
                  parameter: '1.666,67 ',
                ),
                deneme(suffix: '%', header: 'Faiz Oranı', parameter: '0'),
                deneme(
                  prefix: '₺',
                  header: 'Toplam Tutar',
                  parameter: '10.000',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (offer is SponsoredOffers) {
                    launchURL(offer.adUtmLink!);
                  }
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
  }

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

  void _showDetailsPopup(BuildContext context, ActiveOffers loanOffer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoanDetailsPopup(
          loanOffer: loanOffer,
          amountControllerA: amountController,
          maturityControllerA: maturityController,
        );
      },
    );
  }

  void _showSponsoredDetailsPopup(
      BuildContext context, SponsoredOffers loanOffer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SponsoredDetailsPopup(
          sponsoredOffer: loanOffer,
        );
      },
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'URL açılamadı: $url';
    }
  }
}
