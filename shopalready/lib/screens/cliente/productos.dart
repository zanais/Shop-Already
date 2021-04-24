import 'package:flutter/material.dart';
import 'package:shopalready/screens/cliente/carrito.dart';
import '../../widgets/diseño_productos.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/drawer.dart';
import 'package:shopalready/product.dart';

class Productos extends StatefulWidget {
  static const routeName = "productos";

  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
  List<Product> products = [
    Product(
      id: '1',
      image:
          'https://www.cheetos.com/sites/cheetos.com/files/2019-02/Cheetos%20Puffs_0.png',
      title: 'Chetos',
      price: 15,
      cantidad: 4,
    ),
    Product(
      id: '2',
      image:
          'https://d29nyx213so7hn.cloudfront.net/media/catalog/product/cache/9376f1eb816eda0af02b0c0436fe42c0/7/5/750105531088_-_ciel_1lt_pet_4_1.png',
      title: 'Agua',
      price: 10,
      cantidad: 16,
    ),
    Product(
      id: '3',
      image: 'http://assets.stickpng.com/thumbs/580b57fbd9996e24bc43c0de.png',
      title: 'Coca-Cola',
      price: 20,
      cantidad: 5,
    ),
  ];

  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  List<Product> listafiltrada = [];
  @override
  void didChangeDependencies() {
    listafiltrada = [...products];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
            drawer: MyDrawer(
              "Productos",
            ),
            body: Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.all(10.0),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
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
                    itemCount: listafiltrada.length,
                    itemBuilder: (ctx, index) => ProductCard(
                      id: listafiltrada[index].id,
                      image: listafiltrada[index].image,
                      price: listafiltrada[index].price,
                      title: listafiltrada[index].title,
                      cantidad: listafiltrada[index].cantidad,
                    ),
                  )
                ],
              ))
            ])));
  }
}
