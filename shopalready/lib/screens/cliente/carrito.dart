import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import '../../product.dart';
import '../../widgets/drawer.dart';

class Carrito extends StatefulWidget {
  static const routeName = "carrito";

  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<Carrito> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  @override
  Widget build(BuildContext context) {
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
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.teal[100],
        ),
        backgroundColor: Colors.white,
        drawer: MyDrawer("Carrito"),
      ),
    );
  }
}
