import 'package:flutter/cupertino.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [];

  late String authToken;

  ProductProvider(this.authToken, this._items);

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://shopalready-1f15c-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final algoData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if (algoData == null) {
        return;
      }
      algoData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['titulo'],
          price: prodData['precio'],
          image: prodData['image'],
          cantidad: prodData['cantidad'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
      //print(json.decode(response.body));
    } catch (error) {
      throw (error);
    }
  }
}
