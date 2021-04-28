import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String image, title, id;
  final int price, cantidad;

  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.cantidad,
  });
}
