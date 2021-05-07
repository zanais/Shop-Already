import 'package:flutter/cupertino.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [
    /*  Product(
      id: '1',
      image:
          'https://www.cheetos.com/sites/cheetos.com/files/2019-02/Cheetos%20Puffs_0.png',
      title: 'Chetos',
      price: 15,
      cantidad: 4,
    ),
    Product(
      id: '2',
      image:
          'https://d29nyx213so7hn.cloudfront.net/media/catalog/product/cache/9376f1eb816eda0af02b0c0436fe42c0/7/5/750105531088_-_ciel_1lt_pet_4_1.png',
      title: 'Agua',
      price: 10,
      cantidad: 16,
    ),
    Product(
      id: '3',
      image: 'http://assets.stickpng.com/thumbs/580b57fbd9996e24bc43c0de.png',
      title: 'Coca-Cola',
      price: 20,
      cantidad: 5,
    ),*/
  ];

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://shopalready-1f15c-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final extracteData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if (extracteData == null) {
        return;
      }
      extracteData.forEach((prodId, prodData) {
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
