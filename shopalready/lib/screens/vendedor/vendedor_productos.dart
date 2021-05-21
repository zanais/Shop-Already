import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopalready/providers/product.dart';
import 'package:shopalready/providers/products_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopalready/widgets/vendedor_diseno_product.dart';

import 'vendedor_drawer.dart';

class VendedorProductos extends StatefulWidget {
  static const routeName = "vendedor_productos";

  @override
  _VendedorProductosState createState() => _VendedorProductosState();
}

class _VendedorProductosState extends State<VendedorProductos> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  var _isInit = true;
  var _isLoading = false;

  //busqueda [AREGLAR]
  List<Product> listafiltrada = [];
  @override
  void didChangeDependencies() {
    //listafiltrada = [productsData];
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    final products = productsData.items;

    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.productos,
                style: style.copyWith(
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.teal[100],
              iconTheme: IconThemeData(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            drawer: MyDrawer(
              "Productos",
            ),
            body: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(children: <Widget>[
                    Expanded(
                        child: Stack(
                      children: <Widget>[
                        ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (ctx, index) => ChangeNotifierProvider(
                            create: (c) => products[index],
                            child: VendedorProductosDiseno(),
                          ),
                        )
                      ],
                    ))
                  ])));
  }
}
