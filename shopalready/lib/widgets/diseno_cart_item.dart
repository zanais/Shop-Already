import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final int price;
  int cantidad;
  final String title;

  CartItem(
    this.id,
    this.productId,
    this.price,
    this.cantidad,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.redAccent,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(
          productId,
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(title, style: TextStyle(fontSize: 25)),
                  Text('Total: \$${price * cantidad} MXN',
                      style: TextStyle(fontSize: 20)),
                ],
              ),
              IconButton(
                  icon: Icon(Icons.arrow_left, size: 40),
                  onPressed: () {
                    cart.removeSingleItem(productId);
                  }),
              Text(
                '$cantidad',
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                  icon: Icon(Icons.arrow_right, size: 40),
                  onPressed: () {
                    cart.addItem(productId, price, title);
                  }),
            ],
          ),
          /*ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Text('\$$price'),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${price * cantidad} MXN'),
            trailing: Text('$cantidad x'),
            
          ),*/
        ),
      ),
    );
  }
}
