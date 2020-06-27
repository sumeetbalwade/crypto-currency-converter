import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'coin_data.dart';

const apikey = '5DFD3C0F-5ABE-4377-90DB-9B11AE0B9EFF';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String btcprice = "?";
  String ltcprice = "?";
  String ethprice = "?";

  String currency = "USD";

  void calculatebtc(String cfor) async {
    Response response = await get(
        'https://rest.coinapi.io/v1/exchangerate/BTC/$cfor?apikey=$apikey');
    double rate = jsonDecode(response.body)["rate"];
    setState(() {
      btcprice = rate.toStringAsFixed(4);
    });
  }

  void calculateeth(String cfor) async {
    Response response = await get(
        'https://rest.coinapi.io/v1/exchangerate/ETH/$cfor?apikey=$apikey');
    double rate = jsonDecode(response.body)["rate"];
    setState(() {
      ethprice = rate.toStringAsFixed(4);
    });
  }

  void calculateltc(String cfor) async {
    Response response = await get(
        'https://rest.coinapi.io/v1/exchangerate/LTC/$cfor?apikey=$apikey');
    double rate = jsonDecode(response.body)["rate"];
    setState(() {
      ltcprice = rate.toStringAsFixed(4);
    });
  }

  List<DropdownMenuItem> getdropitem() {
    List<DropdownMenuItem> currencyList = [];
    for (String curr in currenciesList) {
      currencyList.add(DropdownMenuItem(
        child: Text(
          curr,
          textAlign: TextAlign.center,
        ),
        value: curr,
      ));
    }
    return currencyList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $btcprice $currency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $ethprice $currency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $ltcprice $currency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0, right: 50.0, left: 50.0),
            color: Colors.lightBlue,
            child: DropdownButton(
                isExpanded: true,
                value: currency,
                items: getdropitem(),
                onChanged: (value) {
                  setState(() {
                    currency = value;
                    calculatebtc(currency);
                    calculateeth(currency);
                    calculateltc(currency);
                  });
                }),
          ),
        ],
      ),
    );
  }
}
