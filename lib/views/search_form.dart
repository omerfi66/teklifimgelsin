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

  int _amountValue = 0;
  num _maturityValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Center(child: Text('Anında Kredi Teklifi Hesapla')),
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
                  side: const BorderSide(color: AppColors.greyColor),
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
                              return 'Lütfen kredi miktarı girin';
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
                          max: 300000,
                          divisions: 300,
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
                              return 'Lütfen vade sayısı girin ';
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
                          value: _maturityValue.toDouble(),
                          min: 0,
                          max: 36,
                          divisions: 36,
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
                              int amount =
                                  int.tryParse(_amountController.text) ?? 0;
                              int maturity =
                                  int.tryParse(_maturityController.text) ?? 0;

                              if (amount >= 50000 &&
                                  amount <= 100000 &&
                                  maturity > 24) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const ErrorDialog();
                                  },
                                );
                              }
                              if (amount > 100000 && maturity >= 13) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const Error2Dialog();
                                  },
                                );
                              } else {
                                try {
                                  final loanOffer =
                                      await LoanService().fetchLoanOffers(
                                    _maturityController.text,
                                    _amountController.text,
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoanListPage(
                                        loanOffers: loanOffer,
                                        amountController: _amountController,
                                        maturityController: _maturityController,
                                      ),
                                    ),
                                  );
                                } on Exception catch (e) {
                                  print(e);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              minimumSize: const Size(double.infinity, 48),
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
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

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Uyarı !'),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: const Text(
        'Bankacılık Düzenleme ve Denetleme Kurumu(BDDK), '
        '06.10.2022 tarihli kurul kararı ile 50.000 TL - 100.000TL '
        'arası kredilerde vade sınırını 36 aydan 24 aya indirmiştir. '
        'Lütfen aramanızı güncelleyin.',
      ),
      actions: const [SizedBox()],
    );
  }
}

class Error2Dialog extends StatelessWidget {
  const Error2Dialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Uyarı !'),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: const Text(
        'Bankacılık Düzenleme ve Denetleme Kurumu(BDDK),'
        '06.10.2022 tarihli kurul kararı ile 100.000 TL'
        'üzeri tüketici kredilerinde vade sınırını 24 aydan 12 aya indirmiştir.'
        'Lütfen aramanızı güncelleyin.',
      ),
      actions: const [SizedBox()],
    );
  }
}
