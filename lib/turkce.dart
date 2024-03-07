import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Offers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoanSearchPage(),
    );
  }
}

class LoanSearchPage extends StatefulWidget {
  const LoanSearchPage({super.key});

  @override
  _LoanSearchPageState createState() => _LoanSearchPageState();
}

class _LoanSearchPageState extends State<LoanSearchPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _maturityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Loan Amount'),
            ),
            TextField(
              controller: _maturityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Maturity'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // LoanService kullanarak API isteğini gerçekleştir
                final loanOffers = await LoanService().fetchLoanOffers(
                  _maturityController.text,
                  _amountController.text,
                );

                // LoanListPage'e yönlendir
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoanListPage(loanOffers: loanOffers),
                  ),
                );
              },
              child: const Text('Search Offers'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoanListPage extends StatelessWidget {
  final List<LoanOffer> loanOffers;

  const LoanListPage({Key? key, required this.loanOffers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Offers'),
      ),
      body: ListView.builder(
        itemCount: loanOffers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(loanOffers[index].bank),
            subtitle: Text('Interest Rate: ${loanOffers[index].interestRate}%'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LoanDetailPage(loanOffer: loanOffers[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class LoanDetailPage extends StatelessWidget {
  final LoanOffer loanOffer;

  const LoanDetailPage({Key? key, required this.loanOffer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bank: ${loanOffer.bank}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text('Annual Rate: ${loanOffer.annualRate}'),
            Text('Interest Rate: ${loanOffer.interestRate}%'),
            Text('Product Name: ${loanOffer.productName}'),
            Text('Sponsored Rate: ${loanOffer.sponsoredRate}'),
          ],
        ),
      ),
    );
  }
}

class LoanService {
  Future<List<LoanOffer>> fetchLoanOffers(
      String maturity, String amount) async {
    final String apiUrl =
        'https://api2.teklifimgelsin.com/api/getLoanOffers?kredi_tipi=0&vade=$maturity&tutar=$amount';

    try {
      final response = await Dio().get(apiUrl);

      if (response.statusCode == 200) {
        final data = response.data;
        final List<dynamic> activeOffers = data['active_offers'];

        List<LoanOffer> loanOffers = [];
        for (var offerData in activeOffers) {
          loanOffers.add(LoanOffer.fromJson(offerData));
        }
        return loanOffers;
      } else {
        throw Exception('Failed to load loan offers');
      }
    } catch (e) {
      throw Exception('Failed to load loan offers: $e');
    }
  }
}

class LoanOffer {
  final double annualRate;
  final String bank;
  final int bankId;
  final String bankType;
  final double interestRate;
  final String productName;
  final double sponsoredRate;
  final String url;

  LoanOffer({
    required this.annualRate,
    required this.bank,
    required this.bankId,
    required this.bankType,
    required this.interestRate,
    required this.productName,
    required this.sponsoredRate,
    required this.url,
  });

  factory LoanOffer.fromJson(Map<String, dynamic> json) {
    return LoanOffer(
      annualRate: (json['annual_rate'] as num).toDouble(),
      bank: json['bank'],
      bankId: json['bank_id'],
      bankType: json['bank_type'],
      interestRate: (json['interest_rate'] as num).toDouble(),
      productName: json['product_name'],
      sponsoredRate: (json['sponsored_rate'] as num).toDouble(),
      url: json['url'],
    );
  }
}
