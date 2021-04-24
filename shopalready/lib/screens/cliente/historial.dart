import 'package:flutter/material.dart';
import '../../widgets/drawer.dart';
import './carrito.dart';

class Historial extends StatefulWidget {
  static const routeName = "historial";
  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        appBar: AppBar(
          title: Text(
            "Historial",
            style: style.copyWith(
              color: Colors.black,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.teal[100],
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.shopping_bag,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Carrito.routeName);
                })
          ],
        ),
        backgroundColor: Colors.white,
        drawer: MyDrawer("Historial"),
      ),
    );
  }
}
