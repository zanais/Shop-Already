import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'cart.dart';

class OrderItemVendedor {
  final String id;
  //final String user;
  final int cantidad;
  final List<CartItem> products;
  final DateTime dateTime;
  //final String email;*/
  // final String userId;

  OrderItemVendedor({
    required this.id,
    //required this.user,
    required this.cantidad,
    required this.dateTime,
    required this.products,
    //required this.email,
  });
}

class OrdersVendedor with ChangeNotifier {
  List<OrderItemVendedor> _ordersVendedor = [];

  final String authToken;
  final String userId;
  //final String emailId;

  OrdersVendedor(
    this.authToken,
    this.userId,
    //this.emailId,
    this._ordersVendedor,
  );

  List<OrderItemVendedor> get ordersVendedor {
    return [..._ordersVendedor];
  }

  Future<void> fetchAndSetOrdersVendedor() async {
    final url = Uri.parse(
        'https://shopalready-1f15c-default-rtdb.firebaseio.com/orders.json');
    final response = await http.get(url);
    final List<OrderItemVendedor> loadedOrders = [];
    final Map<String, dynamic> exctractedData = json.decode(response.body);

    Map<String, dynamic> prueba = exctractedData;
    print('++++++BBBBBBBBBBBBBBBBBBBB++++++');
    var userkeys = prueba.keys.toList();
    List<Map<String, dynamic>> newOrders = [];
    List<String> orderkeys = [];
    userkeys.forEach((userkey) {
      newOrders.add(prueba[userkey]);
    });
    newOrders.forEach((order) {
      var tempList = order.keys.toList();
      tempList.forEach((orderkey) {
        //orderkeys.add(orderkey);
        loadedOrders.add(OrderItemVendedor(
          id: orderkey,
          cantidad: order[orderkey]['cantidad'],
          products: (order[orderkey]['products'] as List<dynamic>)
              .map((item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    cantidad: item['cantidad'],
                    price: item['price'],
                  ))
              .toList(),
          dateTime: DateTime.parse(order[orderkey]['dateTime']),
          //email: emailId,
          //userId: userId,
          //direccion: _direccion,
        ));
      });
    });

    //print(orderkeys);
    _ordersVendedor = loadedOrders.reversed.toList();
    notifyListeners();
  }
}
