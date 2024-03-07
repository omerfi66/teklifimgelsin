import 'package:flutter/material.dart';
import 'package:teklifimgelsin/model/color.dart';
import 'package:teklifimgelsin/service/loan_service.dart';
import 'package:teklifimgelsin/views/resault_screen.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _maturityController = TextEditingController();

  int _amountValue = 30000;
  double _maturityValue = 24;

  @override
  void initState() {
    super.initState();
    _amountController.text = _amountValue.toString();
    _maturityController.text = _maturityValue.toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Anında Kredi Teklifi Hesapla'),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset('assets/images/teklifimgelsin.png'),
              const SizedBox(
                height: 30,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(
                      color: AppColors.greyColor // Border rengini kırmızı yapar
                      ),
                ),
                color: AppColors.whiteColor,
                margin: const EdgeInsets.all(10),
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _amountController,
                          decoration: InputDecoration(
                            labelText: 'Kredi Miktari Girin',
                            filled: true,
                            fillColor: AppColors.backgroundColor,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: AppColors.greyColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            prefix: const Text(
                              '₺',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _amountValue = int.tryParse(value) ?? 0;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the loan amount';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Slider(
                          thumbColor: AppColors.primaryColor,
                          activeColor: AppColors.primaryColor,
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.whiteColor),
                          value: _amountValue.toDouble(),
                          min: 0,
                          max: 300000, // Uygun bir maksimum değer ayarlayın
                          divisions: 300, // Uygun bir bölünme sayısı ayarlayın
                          onChanged: (value) {
                            setState(() {
                              _amountValue = value.toInt();
                              _amountController.text = value.toInt().toString();
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _maturityController,
                          decoration: InputDecoration(
                            suffixText: 'AY',
                            labelText: 'Vade Sayısı Girin',
                            filled: true,
                            fillColor: AppColors.backgroundColor,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: AppColors.greyColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _maturityValue = double.parse(value);
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the loan maturity';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Slider(
                          thumbColor: AppColors.primaryColor,
                          activeColor: AppColors.primaryColor,
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.whiteColor),
                          value: _maturityValue,
                          min: 0,
                          max: 36, // Uygun bir maksimum değer ayarlayın
                          divisions: 36, // Uygun bir bölünme sayısı ayarlayın
                          onChanged: (value) {
                            setState(() {
                              _maturityValue = value;
                              _maturityController.text =
                                  value.toInt().toString();
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              final loanOffers =
                                  await LoanService().fetchLoanOffers(
                                _maturityController.text,
                                _amountController.text,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoanListPage(
                                    loanOffers: loanOffers,
                                    amountController: _amountController,
                                    maturityController: _maturityController,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal:
                                      20), // Düğmenin yatay dolgusunu ayarlar
                              minimumSize: const Size(double.infinity,
                                  48), // Düğmenin minimum boyutunu ayarlar
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15), // Köşe yarıçapını ayarlar
                              ),
                            ),
                            child: const Center(
                                child: Text(
                              'TeklifimGelsin',
                              style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
