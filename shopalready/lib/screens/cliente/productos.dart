import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopalready/providers/cart.dart';
import 'package:shopalready/providers/product.dart';
import 'package:shopalready/screens/cliente/carrito.dart';
import 'package:shopalready/widgets/badge.dart';
import '../../widgets/diseño_productos.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/drawer.dart';
import '../../providers/products_provider.dart';

class Productos extends StatefulWidget {
  static const routeName = "productos";

  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
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
            drawer: MyDrawer(
              "Productos",
            ),
            body: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(children: <Widget>[
                    Container(
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8.0),
                        decoration: BoxDecoration(
                            color: Colors.teal[100],
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                            onChanged: (palabras) {
                              setState(() {
                                if (palabras.isNotEmpty) {
                                  listafiltrada = products
                                      .where((products) => products.title
                                          .toLowerCase()
                                          .contains(palabras.toLowerCase()))
                                      .toList();
                                  listafiltrada.forEach((element) {
                                    print(element.title);
                                  });
                                } else {
                                  listafiltrada = [...products];
                                }
                              });
                            },
                            style: style.copyWith(color: Colors.black),
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: AppLocalizations.of(context)!.busqueda,
                              hintStyle: TextStyle(color: Colors.black),
                            ))),
                    Expanded(
                        child: Stack(
                      children: <Widget>[
                        ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (ctx, index) => ChangeNotifierProvider(
                            create: (c) => products[index],
                            child: ProductCard(
                                //id: products[index].id,
                                //image: products[index].image,
                                //price: products[index].price,
                                //title: products[index].title,
                                //cantidad: products[index].cantidad,
                                ),
                          ),
                        )
                      ],
                    ))
                  ])));
  }
}
