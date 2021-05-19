import 'package:flutter/material.dart';
//import 'package:shopalready/providers/product.dart';
//import 'package:shopalready/providers/products_provider.dart';
//import 'package:shopalready/providers/cart.dart';
//import 'package:shopalready/widgets/badge.dart';
import '../../widgets/drawer.dart';
//import './carrito.dart';
import '../../providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../../widgets/historial_item.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Historial extends StatefulWidget {
  static const routeName = "historial";
  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  var _isLoading = false;
  //String query = '';
  @override
  void initState() {
    _isLoading = true;

    Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    //final nombre = Provider.of<ProductProvider>(context, listen: false);
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
          appBar: AppBar(
            title: Text(
              'Historial',
              //AppLocalizations.of(context)!.carrito,
              style: style.copyWith(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.teal[100],
            iconTheme: IconThemeData(color: Colors.black),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                ),
              )
            ],
          ),
          backgroundColor: Colors.white,
          drawer: MyDrawer("Historial"),
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: ordersData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(ordersData.orders[i]),
                ),
        ));
  }
}
