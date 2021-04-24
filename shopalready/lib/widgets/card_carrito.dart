import 'package:flutter/material.dart';

class CarritoCard extends StatefulWidget {
  @override
  _CarritoCardState createState() => _CarritoCardState();
}

class _CarritoCardState extends State<CarritoCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: null,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Stack(),
            ],
          ),
        ));
  }
}
