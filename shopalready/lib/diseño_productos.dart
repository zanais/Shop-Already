import 'package:flutter/material.dart';
//import 'package:shopalready/product.dart';

class ProductCard extends StatelessWidget {
  final String image, title;
  final int price, cantidad;
  ProductCard(
      {required this.image,
      required this.title,
      required this.price,
      required this.cantidad});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      //color: Colors.amber,
      height: 160,
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
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              height: 160,
              width: 200,
              child: Image(
                  image: NetworkImage(
                image,
                //fit: BoxFit.cover,
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
                    child: Text(title),
                    /* Text(
                      'Agua',
                      style: Theme.of(context).textTheme.button,
                    ),*/
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: 50,
            child: SizedBox(
              height: 136,
              width: size.width - 200,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      price.toString(),
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: 50,
            child: SizedBox(
              height: 136,
              width: size.width - 200,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Cantidad: $cantidad',
                      style: Theme.of(context).textTheme.button,
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
