import 'package:flutter/foundation.dart';
import './cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final int cantidad;
  final List<CartItem> products;
  final DateTime dateTime;
  //final String direccion;

  OrderItem({
    required this.id,
    required this.cantidad,
    required this.products,
    required this.dateTime,
    //required this.direccion,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  final String authToken;
  final String userId;
  // final String _direccion;

  Orders(
    this.authToken,
    this.userId,
    this._orders,
  );

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://shopalready-1f15c-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final exctractedData = json.decode(response.body) as Map<String, dynamic>;
    if (exctractedData == null) {
      return;
    }
    exctractedData.forEach((
      orderId,
      orderData,
    ) {
      loadedOrders.add(OrderItem(
        id: orderId,
        cantidad: orderData['cantidad'],
        products: (orderData['products'] as List<dynamic>)
            .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  cantidad: item['cantidad'],
                  price: item['price'],
                ))
            .toList(),
        dateTime: DateTime.parse(orderData['dateTime']),
        //direccion: _direccion,
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, int total) async {
    final url = Uri.parse(
        'https://shopalready-1f15c-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'cantidad': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'cantidad': cp.cantidad,
                    'price': cp.price,
                  })
              .toList(),
          //'direccion': _direccion,
        }));
    _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          cantidad: total,
          dateTime: timestamp,
          products: cartProducts,
          //direccion: _direccion,
        ));
    //print(_direccion);
    notifyListeners();
  }

  /*void clear() {
    _direccion = '';
    notifyListeners();
  }*/
}
