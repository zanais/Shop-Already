import 'package:flutter/foundation.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final int cantidad;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.cantidad,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, int total) {
    _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          cantidad: total,
          dateTime: DateTime.now(),
          products: cartProducts,
        ));
    notifyListeners();
  }
}
