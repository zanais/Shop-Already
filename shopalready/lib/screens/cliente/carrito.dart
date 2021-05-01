import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/drawer.dart';
import '../../widgets/badge.dart';
import 'package:provider/provider.dart';
import '../../providers/cart.dart' show Cart;
import '../../widgets/diseno_cart_item.dart';
import '../../providers/orders.dart';

class Carrito extends StatefulWidget {
  static const routeName = "carrito";

  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<Carrito> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    //Size size = MediaQuery.of(context).size;
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
                        icon: Icon(Icons.shopping_bag),
                        onPressed: () {
                          Navigator.pushNamed(context, Carrito.routeName);
                        }),
                    value: cart.itemCount.toString(),
                    color: Colors.red),
              )
            ],
          ),
          backgroundColor: Colors.white,
          drawer: MyDrawer("Carrito"),
          body: Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Total', style: TextStyle(fontSize: 20)),
                      Spacer(),
                      Chip(
                        label: Text('\$${cart.totalAmount.toString()}'),
                        backgroundColor: Colors.teal[200],
                      ),
                      TextButton(
                        child: Text('COMPRAR'),
                        onPressed: () {
                          Provider.of<Orders>(context, listen: false).addOrder(
                              cart.items.values.toList(), cart.totalAmount);
                          cart.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: cart.itemCount,
                    itemBuilder: (ctx, i) => CartItem(
                          cart.items.values.toList()[i].id,
                          cart.items.keys.toList()[i],
                          cart.items.values.toList()[i].price,
                          cart.items.values.toList()[i].cantidad,
                          cart.items.values.toList()[i].title,
                        )),
              ),
            ],
          )),
    );
  }
}
