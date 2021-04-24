import 'package:flutter/material.dart';
//import 'package:shopalready/cliente/productos.dart';
//import 'package:shopalready/product.dart';

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  final String image, title, id;
  final int price, cantidad;

  ProductCard({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.cantidad,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat');

  Color _favIconColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
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
                widget.image,
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
                      widget.title,
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
                      '\$' + widget.price.toString(),
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
                      'Cantidad: ${widget.cantidad}',
                      style: style.copyWith(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.shopping_bag,
                size: 40,
              ),
              color: _favIconColor,
              onPressed: () {
                setState(() {
                  if (_favIconColor == Colors.teal) {
                    _favIconColor = Colors.red;
                  } else {
                    _favIconColor = Colors.teal;
                  }
                });
              })
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
