import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  late double _device_width;
  late double _device_Height;

  @override
  Widget build(BuildContext context) {
    _device_Height = MediaQuery.of(context).size.height;
    _device_width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              dropDownMenuForCoins(),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropDownMenuForCoins() {
    List _coins = ['bitcoin'];
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
          fontSize: _device_Height * 0.05,
          fontWeight: FontWeight.w600,
        ),
        value: _coins.first,
        underline: Container(),
        items: _items,
        onChanged: (value) {},
      ),
    );
  }
}
