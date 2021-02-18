import 'package:flutter/material.dart';
//import 'package:shopalready/appbar.dart';
import 'package:shopalready/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class Productos extends StatefulWidget {
  Productos({Key key}) : super(key: key);

  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Widget salirButton = FlatButton(
      child: Text("Salir"),
      onPressed: () {
        _auth.signOut();
        print('salido');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("¿Desea salir?"),
      actions: [salirButton, cancelButton],
    );
    //Size size = MediaQuery.of(context).size;
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        appBar: AppBar(
          title: Text('Productos'),
          backgroundColor: Colors.teal[100],
        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Usuario'),
              accountEmail: Text(user.email),
              decoration: BoxDecoration(
                color: Colors.red[200],
              ),
            ),
            ListTile(
              leading: Icon(Icons.store_mall_directory),
              title: Text('Productos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Carrito'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Productos()));
              },
            ),
            ListTile(
                leading: Icon(Icons.input),
                title: Text('Cerrar Sesión'),
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
      ),
    );
  }
}
