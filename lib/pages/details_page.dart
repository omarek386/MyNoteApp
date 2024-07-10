// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  Map prices;
  DetailsPage({
    super.key,
    required this.prices,
  });

  @override
  Widget build(BuildContext context) {
    var pricesList = prices.values.toList();
    var coinsList = prices.keys.toList();
    return Scaffold(
      body: ListView.builder(
        itemCount: pricesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(
              '${coinsList[index].toString().toUpperCase()} : ${pricesList[index]}',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          );
        },
      ),
    );
  }
}
