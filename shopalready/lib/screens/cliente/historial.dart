import 'package:flutter/material.dart';
import 'package:shopalready/providers/cart.dart';
import 'package:shopalready/widgets/badge.dart';
import '../../widgets/drawer.dart';
import './carrito.dart';
import '../../providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../../widgets/historial_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Historial extends StatefulWidget {
  static const routeName = "historial";
  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.carrito,
              style: style.copyWith(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.teal[100],
            iconTheme: IconThemeData(color: Colors.black),
            actions: <Widget>[
              Consumer<Cart>(
                builder: (_, cart, child) => Badge(
                    child: IconButton(
                        icon: Icon(
                          Icons.shopping_bag,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, Carrito.routeName);
                        }),
                    value: cart.itemCount.toString(),
                    color: Colors.red),
              )
            ],
          ),
          backgroundColor: Colors.white,
          drawer: MyDrawer("Historial"),
          body: ListView.builder(
            itemCount: ordersData.orders.length,
            itemBuilder: (ctx, i) => OrderItem(ordersData.orders[i]),
          )),
    );
  }
}
