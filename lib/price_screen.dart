import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'services/networking.dart';



class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = currenciesList[0];
  List<int> rates = List<int>.filled(cryptoList.length, 0);
  String apiKey = 'D7523C25-144F-4282-94CA-868D620EE51C';

  DropdownButton androidDropdown() {
    return DropdownButton<String>(
        value: selectedCurrency,
        menuMaxHeight: 300,
        items: [
          for (String currency in currenciesList)
            DropdownMenuItem(
              value: currency,
              child: Text(currency),
            )
        ],
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            getRates();
          });
        });
  }

  CupertinoPicker iosPicker() {
    return CupertinoPicker(
      onSelectedItemChanged: (int index) {
        selectedCurrency = currenciesList[index];
        getRates();
      },
      itemExtent: 32,
      children: [for (String currency in currenciesList) Text(currency)],
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iosPicker();
    } else {
      return androidDropdown();
    }
  }

  void getRates() async {
    int counter = 0;
    for (String cryptoCurrency in cryptoList){
      String rateRequest =
        'https://rest.coinapi.io/v1/exchangerate/$cryptoCurrency/$selectedCurrency/apikey-$apiKey';
      NetworkHelper netHelp = NetworkHelper(rateRequest);
      rates[counter] = await netHelp.getData();
      counter ++;
    }
    setState(() {
      rates = rates;
    });
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex:4,
            child: Container(
              //height: 600,
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (String cryptoCurrency in cryptoList)
                    CryptoCard(
                        rate: rates[cryptoList.indexOf(cryptoCurrency)],
                        cryptoCurrency: cryptoCurrency,
                        selectedCurrency: selectedCurrency)
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              //height: 140.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: androidDropdown(),
            ),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    super.key,
    required this.rate,
    required this.cryptoCurrency,
    required this.selectedCurrency,
  });

  final int rate;
  final String cryptoCurrency;
  final String? selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $rate $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
