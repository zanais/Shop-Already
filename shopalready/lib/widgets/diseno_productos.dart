import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopalready/providers/cart.dart';
//import 'package:shopalready/providers/products_provider.dart';
//import '../screens/cliente/productos.dart';
import '../providers/product.dart';

class ProductCard extends StatefulWidget {
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat');

  @override
  Widget build(BuildContext context) {
    final productos = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
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
            bottom: 0,
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
            bottom: -30,
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
            bottom: -60,
            left: 50,
            child: SizedBox(
              height: 136,
              width: size.width - 200,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Cantidad: ${productos.cantidad}',
                      style: style.copyWith(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.shopping_bag, size: 40),
            onPressed: () {
              cart.addItem(productos.id, productos.price, productos.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Se agregó el producto al carrito'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'Deshacer',
                    onPressed: () {
                      cart.removeSingleItem(productos.id);
                    },
                  ),
                ),
              );
            },
            color: Colors.teal,
          )
          /*ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) return Colors.blue;
                return Colors.yellow;
              }),
              alignment: Alignment.centerLeft,
            ),
            onPressed: () {
              print("prsionado");
            },
            child: Text(
              "Comprar",
              style: style.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )*/
        ],
      ),
    );
  }
}
