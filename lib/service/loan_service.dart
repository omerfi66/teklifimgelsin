import 'package:dio/dio.dart';
import 'package:teklifimgelsin/model/loan_offer.dart';

class LoanService {
  Future<LoanOffer> fetchLoanOffers(String maturity, String amount) async {
    final String apiUrl =
        'https://api2.teklifimgelsin.com/api/getLoanOffers?kredi_tipi=0&vade=$maturity&tutar=$amount';

    try {
      final response = await Dio().get(apiUrl);

      if (response.statusCode == 200) {
        final data = response.data;

        final errorMessage = data['error_message'];
        if (errorMessage != null) {
          throw Exception(errorMessage);
        }

        return LoanOffer.fromJson(data);
      } else {
        throw Exception('Failed to load loan offers');
      }
    } catch (e) {
      rethrow;
    }
  }
}
