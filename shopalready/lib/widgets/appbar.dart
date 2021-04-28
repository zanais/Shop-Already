import 'package:flutter/material.dart';
import 'package:shopalready/screens/cliente/carrito.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context, String title) {
    return AppBar(
      title: Text(
        title,
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
    );
  }
}
