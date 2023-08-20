import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Map rates;
  const DetailsPage({required this.rates});

  @override
  Widget build(BuildContext context) {
    List _currencies = rates.keys.toList();
    List _xchangeRates = rates.values.toList();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: _currencies.length,
            itemBuilder: (_context, index) {
              String _currency = _currencies[index].toString().toUpperCase();
              String _xchangeRate =
                  _xchangeRates[index].toString().toUpperCase();
              return ListTile(
                title: Text(
                  "$_currency:$_xchangeRate",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              );
            }),
      ),
    );
  }
}
