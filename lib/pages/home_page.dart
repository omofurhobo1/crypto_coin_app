import 'dart:convert';

import 'package:crypto_coin_app/pages/details_page.dart';
import 'package:crypto_coin_app/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  HttpService? _http;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _http = GetIt.instance.get<HttpService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _coinsDropDownButton(),
              _dataWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _coinsDropDownButton() {
    List<String> _coins = [
      "bitcoin",
      "etherium",
      "tether",
      "cardano",
      "ripple"
    ];
    List<DropdownMenuItem<String>> _item = _coins
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
        .toList();
    return DropdownButton(
      dropdownColor: Color.fromRGBO(83, 88, 206, 1.0),
      icon: Icon(
        Icons.arrow_drop_down_sharp,
        color: Colors.white,
      ),
      iconSize: 30,
      value: _coins.first,
      items: _item,
      onChanged: (_value) {},
      underline: Container(),
    );
  }

  Widget _dataWidget() {
    return FutureBuilder(
        future: _http!.get("/coins/bitcoin"),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            Map _data = jsonDecode(
              _snapshot.data.toString(),
            );
            num _usdPrice = _data["market_data"]["current_price"]["usd"];
            num _change = _data["market_data"]["price_change_percentage_24h"];
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onDoubleTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext _context) {
                        return DetailsPage();
                      }));
                    },
                    child: _coinImage(_data["image"]["large"])),
                _currentPrice(_usdPrice),
                _percentageChangeIn24Hr(_change),
                _descriptionCardWidget(_data["description"]["en"])
              ],
            );
          } else
            return Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
        });
  }

  Widget _currentPrice(num _rate) {
    return Text(
      "${_rate.toStringAsFixed(2)} USD",
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _percentageChangeIn24Hr(num _change) {
    return Text(
      "${_change.toString()}%",
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );
  }

  Widget _coinImage(String _imageUrl) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.02),
      height: _deviceHeight! * 0.15,
      width: _deviceWidth! * 0.15,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_imageUrl),
        ),
      ),
    );
  }

  Widget _descriptionCardWidget(String _description) {
    return Container(
      color: Color.fromRGBO(83, 88, 206, 0.5),
      height: _deviceHeight! * 0.45,
      width: _deviceWidth! * 0.90,
      margin: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.05),
      padding: EdgeInsets.symmetric(
        vertical: _deviceHeight! * 0.01,
        horizontal: _deviceWidth! * 0.01,
      ),
      child: Text(
        "$_description",
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
