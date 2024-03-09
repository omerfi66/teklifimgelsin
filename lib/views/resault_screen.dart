// import 'package:flutter/material.dart';
// import 'package:teklifimgelsin/controller/search_form_controller.dart';
// import 'package:teklifimgelsin/model/color.dart';
// import 'package:teklifimgelsin/model/loan_offer.dart';
// import 'package:teklifimgelsin/views/detail_screen.dart';
// import 'package:url_launcher/url_launcher.dart';

// class LoanListPage extends StatelessWidget {
//   final LoanOffer loanOffers;

//   final TextEditingController amountController;
//   final TextEditingController maturityController;

//   const LoanListPage({
//     Key? key,
//     required this.loanOffers,
//     required this.amountController,
//     required this.maturityController,
//   }) : super(key: key);

//   /// =======----------asagidaki  yorum satirindaki metotlari Controller sayfasina attim, suan oradan calisiyor.-------===========
//   /// =======----------ama istege orasi silinir burdaki yorumlar kaldirilip burasi kullanilir---------------------============

//   // String formatAmount(String amountText) {
//   //   double amount = double.tryParse(amountText) ?? 0.0;
//   //   final formatter = NumberFormat("#,##0", "tr_TR");
//   //   return formatter.format(amount);
//   // }

//   // String formatMonthly(String amountText) {
//   //   double amount = double.tryParse(amountText) ?? 0.0;
//   //   final formatter = NumberFormat("#,##0.00", "tr_TR");
//   //   return formatter.format(amount);
//   // }

//   // double calculateMonthlyPayment(
//   //     double amount, double totalInterestRate, int maturityController) {
//   //   double monthlyPayment = (amount *
//   //           totalInterestRate *
//   //           pow(1 + totalInterestRate, maturityController)) /
//   //       (pow(1 + totalInterestRate, maturityController) - 1);
//   //   return monthlyPayment;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         title: const Text('Kredi Teklifleri'),
//         backgroundColor: AppColors.backgroundColor,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: loanOffers.activeOffers?.length ?? 0,
//         itemBuilder: (context, index) {
//           final loanOffer = loanOffers.activeOffers![index];
//           // final suponsored = loanOffers.sponsoredOffers![index];

//           return Card(
//             color: AppColors.whiteColor,
//             margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//               side: const BorderSide(
//                 color: Colors.grey,
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             loanOffer.bank ?? '',
//                             style: const TextStyle(
//                                 fontSize: 20.0, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         child: Row(
//                           children: [
//                             const Row(
//                               children: [
//                                 Icon(
//                                   Icons.check_circle_outlined,
//                                   color: Colors.green,
//                                 ),
//                                 Text(
//                                   'Reklam',
//                                   style: TextStyle(color: Colors.green),
//                                 )
//                               ],
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 _showDetailsPopup(context, loanOffer,
//                                     maturityController, amountController);
//                               },
//                               child: const Text(
//                                 'Detaylar >',
//                                 style:
//                                     TextStyle(color: AppColors.optionalColor),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Column(
//                       //   children: [
//                       //     const Text('Aylık Taksit'),
//                       //     Text(
//                       //       '₺${formatMonthly(calculateMonthlyPayment(double.parse(amountController.text), loanOffer.interestRate! * 0.013, int.parse(maturityController.text)).toStringAsFixed(2))}',
//                       //       style: const TextStyle(fontWeight: FontWeight.bold),
//                       //     ),
//                       //   ],
//                       // ),

//                       // Column(
//                       //   children: [
//                       //     const Text('Faiz Oranı'),
//                       //     Text(
//                       //       '${loanOffer.interestRate}%',
//                       //       style: const TextStyle(fontWeight: FontWeight.bold),
//                       //     ),
//                       //   ],
//                       // ),

//                       // Column(
//                       //   children: [
//                       //     const Text('Toplam Tutar'),
//                       //     Text(
//                       //       '₺${formatAmount(amountController.text)}*',
//                       //       style: const TextStyle(fontWeight: FontWeight.bold),
//                       //     ),
//                       //   ],
//                       // ),
//                       deneme(
//                           prefix: '₺',
//                           header: 'Aylık Taksit',
//                           parameter: formatMonthly(calculateMonthlyPayment(
//                                   double.parse(amountController.text),
//                                   loanOffer.interestRate! * 0.013,
//                                   int.parse(maturityController.text))
//                               .toStringAsFixed(2))),

//                       deneme(
//                           suffix: '%',
//                           header: 'Faiz Oranı',
//                           parameter: loanOffer.interestRate),
//                       deneme(
//                           prefix: '₺',
//                           header: 'Toplam Tutar',
//                           parameter: formatAmount(amountController.text)),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Center(
//                     child: ElevatedButton(
//                       // onPressed: () {
//                       //   _applyForLoan(context, loanOffer);

//                       // },
//                       onPressed: () {
//                         _launchURL(
//                             loanOffer.url!); // loanOffer.url ile URL'yi alın
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         minimumSize: const Size(double.infinity, 48),
//                         backgroundColor: AppColors.primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.open_in_new,
//                             color: AppColors.whiteColor,
//                           ),
//                           SizedBox(width: 8),
//                           Text(
//                             'Hemen Başvur !',
//                             style: TextStyle(
//                                 color: AppColors.whiteColor,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   /// =======----------asagidaki  yorum satirindaki kodu Controller sayfasina attim, suan oradan calisiyor.-------===========
//   /// =======----------ama istege orasi silinir burdaki yorumlar kaldirilip burasi kullanilir---------------------============

//   // dynamic deneme({prefix = '', header = '', parameter = '', suffix = ''}) {
//   //   return Column(
//   //     children: [
//   //       Text(header),
//   //       Text(
//   //         '$prefix$parameter$suffix',
//   //         style: const TextStyle(fontWeight: FontWeight.bold),
//   //       ),
//   //     ],
//   //   );
//   // }

//   void _showDetailsPopup(
//     BuildContext context,
//     ActiveOffers loanOffer,
//     TextEditingController maturityController,
//     TextEditingController amountController,
//   ) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return LoanDetailsPopup(
//           loanOffer: loanOffer,
//           amountControllerA: amountController,
//           maturityControllerA: maturityController,
//         );
//       },
//     );
//   }

//   // void _applyForLoan(BuildContext context, ActiveOffers loanOffer) {
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(content: Text('Başvuru yapıldı: ${loanOffer.bank}')),
//   //   );
//   // }
//   void _launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'URL açılamadı: $url';
//     }
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:teklifimgelsin/controller/search_form_controller.dart';
// // import 'package:teklifimgelsin/model/color.dart';
// // import 'package:teklifimgelsin/model/loan_offer.dart';
// // import 'package:teklifimgelsin/views/detail_screen.dart';

// // class LoanListPage extends StatelessWidget {
// //   final LoanOffer loanOffers;

// //   final TextEditingController amountController;
// //   final TextEditingController maturityController;

// //   const LoanListPage({
// //     Key? key,
// //     required this.loanOffers,
// //     required this.amountController,
// //     required this.maturityController,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.backgroundColor,
// //       appBar: AppBar(
// //         title: const Text('Kredi Teklifleri'),
// //         backgroundColor: AppColors.backgroundColor,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back_ios),
// //           onPressed: () {
// //             Navigator.of(context).pop();
// //           },
// //         ),
// //       ),
// //       body: ListView.builder(
// //         itemCount: loanOffers.activeOffers?.length ?? 0,
// //         itemBuilder: (context, index) {
// //           final loanOffer = loanOffers.activeOffers![index];
// //           return LoanCard(
// //             loanOffer: loanOffer,
// //             amountController: amountController,
// //             maturityController: maturityController,
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // class LoanCard extends StatefulWidget {
// //   final ActiveOffers loanOffer;
// //   final TextEditingController amountController;
// //   final TextEditingController maturityController;

// //   const LoanCard({
// //     Key? key,
// //     required this.loanOffer,
// //     required this.amountController,
// //     required this.maturityController,
// //   }) : super(key: key);

// //   @override
// //   _LoanCardState createState() => _LoanCardState();
// // }

// // class _LoanCardState extends State<LoanCard> {
// //   String _buttonText = 'Hemen Başvur!';

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       color: AppColors.whiteColor,
// //       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(15),
// //         side: const BorderSide(
// //           color: Colors.grey,
// //         ),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Text(
// //                       widget.loanOffer.bank ?? '',
// //                       style: const TextStyle(
// //                           fontSize: 20.0, fontWeight: FontWeight.bold),
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(
// //                   child: Row(
// //                     children: [
// //                       const Row(
// //                         children: [
// //                           Icon(
// //                             Icons.check_circle_outlined,
// //                             color: Colors.green,
// //                           ),
// //                           Text(
// //                             'Reklam',
// //                             style: TextStyle(color: Colors.green),
// //                           )
// //                         ],
// //                       ),
// //                       TextButton(
// //                         onPressed: () {
// //                           _showDetailsPopup(context, widget.loanOffer);
// //                         },
// //                         child: const Text(
// //                           'Detaylar >',
// //                           style: TextStyle(color: AppColors.optionalColor),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 )
// //               ],
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 deneme(
// //                     prefix: '₺',
// //                     header: 'Aylık Taksit',
// //                     parameter: formatMonthly(calculateMonthlyPayment(
// //                             double.parse(widget.amountController.text),
// //                             widget.loanOffer.interestRate! * 0.013,
// //                             int.parse(widget.maturityController.text))
// //                         .toStringAsFixed(2))),
// //                 deneme(
// //                     suffix: '%',
// //                     header: 'Faiz Oranı',
// //                     parameter: widget.loanOffer.interestRate),
// //                 deneme(
// //                     prefix: '₺',
// //                     header: 'Toplam Tutar',
// //                     parameter: formatAmount(widget.amountController.text)),
// //               ],
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Center(
// //               child: ElevatedButton(
// //                 onPressed: () {
// //                   _applyForLoan(context, widget.loanOffer);
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   padding: const EdgeInsets.symmetric(horizontal: 20),
// //                   minimumSize: const Size(double.infinity, 48),
// //                   backgroundColor: AppColors.primaryColor,
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(15),
// //                   ),
// //                 ),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     const Icon(
// //                       Icons.open_in_new,
// //                       color: AppColors.whiteColor,
// //                     ),
// //                     const SizedBox(width: 8),
// //                     Text(
// //                       _buttonText,
// //                       style: const TextStyle(
// //                           color: AppColors.whiteColor,
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _showDetailsPopup(BuildContext context, ActiveOffers activeOffers) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return LoanDetailsPopup(
// //           loanOffer: activeOffers,
// //         );
// //       },
// //     );
// //   }

// //   void _applyForLoan(BuildContext context, ActiveOffers loanOffer) {
// //     setState(() {
// //       _buttonText = 'Başvuru yapıldı';
// //     });

// //     // Simülasyon amaçlı 1 saniye sonra tekrar eski haline dönsün
// //     Future.delayed(const Duration(seconds: 1), () {
// //       setState(() {
// //         _buttonText = 'Hemen Başvur !';
// //       });
// //     });
// //   }
// // }

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
          return Container(); // Placeholder, buraya bir şey dönmüyoruz
        },
        //groupSeparatorBuilder: (String groupByValue) => const Divider(),
        groupSeparatorBuilder: (String groupByValue) {
          return groupByValue == 'Active Offers'
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 3,
                  ),
                )
              : Container();
        },
        order: GroupedListOrder.DESC, // optional
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
                  parameter: formatMonthly(calculatetotalCost(
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
                    _launchURL(offer.url!);
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
                    _launchURL(offer.adUtmLink!);
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

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'URL açılamadı: $url';
    }
  }
}
