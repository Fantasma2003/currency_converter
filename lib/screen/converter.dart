import 'package:currency_converter/model/currency.dart';
import 'package:currency_converter/repository/converter_repo.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConverterApp extends StatefulWidget {
  const ConverterApp({super.key});

  @override
  State<ConverterApp> createState() => _ConverterAppState();
}

class _ConverterAppState extends State<ConverterApp> {
  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();

  Currency firstCurrency = Currency(flagCode: 'NG', key: 'NGN');
  Currency secondCurrency = Currency(flagCode: 'US', key: 'USD');

  double firstAmount = 1000;
  double secondAmount = 73704.26;

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Currency Converter',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _displayFirstBottomSheet(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'From',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 21,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                          ),
                          child: Row(
                            children: [
                              Flag.fromString(
                                firstCurrency.flagCode.toLowerCase(),
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                firstCurrency.key,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 3),
                              const Icon(Icons.arrow_drop_down_outlined)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      swapCurrency();
                    },
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.swap_horiz,
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _displaySecondBottomSheet(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'To',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 21,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                          ),
                          child: Row(
                            children: [
                              Flag.fromString(
                                secondCurrency.flagCode.toLowerCase(),
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                secondCurrency.key,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 3),
                              const Icon(Icons.arrow_drop_down_outlined)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text('Enter Amount', style: TextStyle(fontSize: 22)),
              const SizedBox(height: 10),
              Container(
                height: 55,
                padding: const EdgeInsets.only(left: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: TextField(
                  controller: firstController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Converted Amount', style: TextStyle(fontSize: 22)),
              const SizedBox(height: 10),
              Container(
                height: 55,
                padding: const EdgeInsets.only(left: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: TextField(
                  controller: secondController,
                  readOnly: true,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    convertCurrency();
                  },
                  child: const Text(
                    'Convert',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void swapCurrency() {
    setState(() {
      Currency temp = firstCurrency;
      firstCurrency = secondCurrency;
      secondCurrency = temp;
    });
  }

  void convertCurrency() async {
    double convertedAmount = await ConverterRepo().getRateForAmount(
      firstCountry: firstCurrency.key,
      secondCountry: secondCurrency.key,
      amount: double.parse(firstController.value.text),
    );

    setState(() {
      secondController.text = convertedAmount.toString();
    });
  }

  Future _displayFirstBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .5,
          child: Column(
            children: [
              Container(
                height: 10,
                width: 80,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: currencyList.length,
                  itemBuilder: (context, index) {
                    final currency = currencyList[index];
                    return GestureDetector(
                      onTap: () => changeFirstCurrency(currency),
                      child: CountryListTile(currency: currency),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future _displaySecondBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .5,
          child: Column(
            children: [
              Container(
                height: 10,
                width: 80,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: currencyList.length,
                  itemBuilder: (context, index) {
                    final currency = currencyList[index];
                    return GestureDetector(
                      onTap: () => changeSecondCurrency(currency),
                      child: CountryListTile(currency: currency),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void changeFirstCurrency(Currency currency) {
    setState(() {
      firstCurrency = currency;
    });
    Navigator.pop(context);
  }

  void changeSecondCurrency(Currency currency) {
    setState(() {
      secondCurrency = currency;
    });
    Navigator.pop(context);
  }
}

class CountryListTile extends StatelessWidget {
  const CountryListTile({
    super.key,
    required this.currency,
  });

  final Currency currency;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Flag.fromString(
        currency.flagCode.toLowerCase(),
        height: 30,
        width: 30,
      ),
      title: Text(
        currency.key,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
