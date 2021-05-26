import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';
import 'dart:math';
//import '../providers/orders.dart' as ord;
import 'package:intl/intl.dart';
import '../providers/order_vendedor.dart' as ord;

class VendedorOrdenesItem extends StatefulWidget {
  final ord.OrderItemVendedor order;

  VendedorOrdenesItem(this.order);
  @override
  _VendedorOrdenesItemState createState() => _VendedorOrdenesItemState();
}

class _VendedorOrdenesItemState extends State<VendedorOrdenesItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    //final ordersnormales = Provider.of<Orders>(context, listen: false);
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.cantidad} MXN'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.products.length * 20 + 10, 100),
              child: ListView(
                  children: widget.order.products
                      .map((prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod.title,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text('${prod.cantidad}x \$${prod.price} MXN',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  )),
                            ],
                          ))
                      .toList()),
            ),

          //Text(widget.order.authToken),
        ],
      ),
    );
  }
}
