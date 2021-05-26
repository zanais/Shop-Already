import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopalready/providers/product.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VendedorProductosDiseno extends StatefulWidget {
  @override
  _VendedorProductosDisenoState createState() =>
      _VendedorProductosDisenoState();
}

class _VendedorProductosDisenoState extends State<VendedorProductosDiseno> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat');

  @override
  Widget build(BuildContext context) {
    final productos = Provider.of<Product>(context);
    Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 4,
      //color: Colors.amber,
      //height: 160,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: 136,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.red[200],
            ),
            child: Container(
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: Colors.teal[100],
                  borderRadius: BorderRadius.circular(22)),
            ),
          ),
          Positioned(
            top: 14,
            right: -15,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              height: 160,
              width: 200,
              child: Image(
                  image: NetworkImage(
                productos.image,
              )),
            ),
          ),
          Positioned(
            bottom: -10,
            left: 50,
            child: SizedBox(
              height: 136,
              width: size.width - 200,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      productos.title,
                      style: style.copyWith(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: 50,
            child: SizedBox(
              height: 136,
              width: size.width - 200,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      '\$' + productos.price.toString() + ' MXN',
                      style: style.copyWith(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -90,
            left: 50,
            child: SizedBox(
              height: 136,
              width: size.width - 200,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      AppLocalizations.of(context)!.cantidad +
                          ': ${productos.cantidad}',
                      style: style.copyWith(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
