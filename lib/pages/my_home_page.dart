import 'dart:convert';

import 'package:asfasfasf/services/http_service.dart';
import 'package:flutter/material.dart';

import 'details_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late double device_width, device_Height;

  String _selected_coin = 'bitcoin';

  @override
  Widget build(BuildContext context) {
    device_Height = MediaQuery.of(context).size.height;
    device_width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              dropDownMenuForCoins(),
              _content(_selected_coin),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropDownMenuForCoins() {
    List _coins = [
      'bitcoin',
      'ethereum',
      'tether',
      'cardano',
      'ripple',
    ];
    List<DropdownMenuItem> _items = _coins
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ),
        )
        .toList();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton(
        style: TextStyle(
          color: Colors.black,
          fontSize: device_Height * 0.05,
          fontWeight: FontWeight.w600,
        ),
        value: _selected_coin,
        underline: Container(),
        items: _items,
        onChanged: (dynamic _value) {
          _selected_coin = _value;
          setState(() {});
          // setState(() {});
        },
      ),
    );
  }

  Widget descriptionBox(String _description) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(31, 81, 23, 0.5),
      ),
      height: device_Height * 0.45,
      width: device_width * 0.9,
      child: ListView(
        children: [
          Text(_description),
        ],
      ),
    );
  }

  Widget _coinPrice(num _price, num _change24h) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            '${_price.toString()} USD',
            style:
                TextStyle(color: Colors.white, fontSize: device_Height * 0.04),
          ),
          Text(
            '${_change24h.toString()} %',
            style:
                TextStyle(color: Colors.white, fontSize: device_Height * 0.02),
          )
        ],
      ),
    );
  }

  Widget _image(String _url) {
    return Container(
      height: device_Height * 0.1,
      width: device_width * 0.2,
      decoration: BoxDecoration(
        color: Colors.red,
        image: DecorationImage(
          image: NetworkImage(_url),
        ),
      ),
    );
  }

  Widget _content(String _coin) {
    return FutureBuilder(
      future: HttpService().get('/coins/$_coin'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map _data = jsonDecode(snapshot.data.toString());
          num _usdPrice = _data['market_data']['current_price']['usd'];
          num _change24h = _data['market_data']['price_change_percentage_24h'];
          Map _rates = _data['market_data']['current_price'];
          String _description = _data['description']['en'];
          String _url = _data['image']['large'];
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onDoubleTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return DetailsPage(
                        prices: _rates,
                      );
                    },
                  ));
                },
                child: _image(_url),
              ),
              _coinPrice(_usdPrice, _change24h),
              descriptionBox(_description),
            ],
          );
        } else {
          return CircularProgressIndicator(
            color: Colors.white,
          );
        }
      },
    );
  }
}
