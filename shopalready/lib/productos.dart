import 'package:flutter/material.dart';
import 'package:shopalready/carrito.dart';
import 'package:shopalready/diseño_productos.dart';
//import 'package:shopalready/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopalready/product.dart';
import 'package:shopalready/prueba.dart';
import 'package:shopalready/tipos_usuarios.dart';

class Productos extends StatefulWidget {
  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  List<Product> products = [
    Product(
      // id: 1,
      image:
          'https://www.cheetos.com/sites/cheetos.com/files/2019-02/Cheetos%20Puffs_0.png',
      title: 'Chetos',
      price: 15,
      cantidad: 4,
    ),
    Product(
      // id: 2,
      image:
          'https://d29nyx213so7hn.cloudfront.net/media/catalog/product/cache/9376f1eb816eda0af02b0c0436fe42c0/7/5/750105531088_-_ciel_1lt_pet_4_1.png',
      title: 'Agua',
      price: 10,
      cantidad: 16,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Widget salirButton = TextButton(
      child: Text(AppLocalizations.of(context)!.salir),
      onPressed: () {
        _auth.signOut();
        print('salido');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TiposDeUsuarios()),
        );
      },
    );
    Widget cancelButton = TextButton(
      child: Text(AppLocalizations.of(context)!.cancelar),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(AppLocalizations.of(context)!.deseasalir),
      actions: [salirButton, cancelButton],
    );

    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.productos),
              backgroundColor: Colors.teal[100],
            ),
            backgroundColor: Colors.white,
            drawer: Drawer(
              child: ListView(padding: EdgeInsets.zero, children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('Usuario'),
                  accountEmail: Text('@User'),
                  decoration: BoxDecoration(
                    color: Colors.red[200],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.store_mall_directory),
                  title: Text(AppLocalizations.of(context)!.productos),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text(AppLocalizations.of(context)!.carrito),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Carrito()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text(AppLocalizations.of(context)!.traducir),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => Prueba(),
                    );
                  },
                ),
                ListTile(
                    leading: Icon(Icons.input),
                    title: Text(AppLocalizations.of(context)!.cerrar),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }),
              ]),
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
                      style: TextStyle(color: Colors.black),
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
                    itemBuilder: (context, index) => ProductCard(
                      image: products[index].image,
                      price: products[index].price,
                      title: products[index].title,
                      cantidad: products[index].cantidad,
                    ),
                  )
                ],
              ))
            ])));
  }
}
