import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'CCFFD437-843E-4696-80DE-136BB9E500AB';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //---------------------------------------------------------
  var priceBTC;
  var currencyName;
  var coinName;

  void getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/BTC/INR?apikey=$apiKey'));
    if (response.statusCode == 200) {
      String data = response.body;

      var coin = jsonDecode(data)['asset_id_base'];
      var price = jsonDecode(data)['rate'];
      var currency = jsonDecode(data)['asset_id_quote'];
      setState(() {
        priceBTC = price;
        currencyName = currency;
        coinName = coin;
      });

      print(price);
      print(currency);
      print(coin);
    } else {
      print(response.statusCode);
    }
  }

//---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bitcoin Price Tracker'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  getData();
                },
                child: Text('Get Data'),
              ),
              Text(
                  'Currency = $currencyName \n price = $priceBTC \n coin name = $coinName'),
            ],
          ),
        ),
      ),
    );
  }
}
