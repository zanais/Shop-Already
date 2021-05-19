import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../screens/cliente/carrito.dart';
import '../screens/cliente/historial.dart';
import '../screens/cliente/productos.dart';
import '../widgets/prueba.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class MyDrawer extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyDrawer(this.currentPage);
  final String currentPage;

  @override
  Widget build(BuildContext context) {
    final email = Provider.of<Auth>(context, listen: false);
    Widget salirButton = TextButton(
      child: Text(AppLocalizations.of(context)!.salir),
      onPressed: () {
        _auth.signOut();
        Navigator.pushReplacementNamed(context, '/');
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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Cliente'),
            accountEmail: Text(email.emailId),
            decoration: BoxDecoration(
              color: Colors.red[200],
            ),
          ),
          ListTile(
            leading: Icon(Icons.store_mall_directory),
            title: Text(AppLocalizations.of(context)!.productos),
            onTap: () {
              //Navigator.pop(context);
              Navigator.of(context).pop();
              if (this.currentPage == "Productos") return;

              Navigator.pushReplacementNamed(context, Productos.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text(AppLocalizations.of(context)!.carrito),
            onTap: () {
              Navigator.of(context).pop();
              if (this.currentPage == "Carrito") return;

              Navigator.pushReplacementNamed(context, Carrito.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text("Historial"),
            onTap: () {
              Navigator.of(context).pop();
              if (this.currentPage == "Historial") return;

              Navigator.pushReplacementNamed(context, Historial.routeName);
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
        ],
      ),
    );
  }
}
