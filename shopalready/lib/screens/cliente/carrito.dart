import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopalready/widgets/appbar.dart';
//import '../../product.dart';
import '../../widgets/drawer.dart';
import '../../widgets/appbar.dart';

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
        appBar: MyAppBar(context, AppLocalizations.of(context)!.carrito),
        backgroundColor: Colors.white,
        drawer: MyDrawer("Carrito"),
      ),
    );
  }
}
