import 'package:dio/dio.dart';
import 'package:teklifimgelsin/model/loan_offer.dart';

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
