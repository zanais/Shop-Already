import 'package:flutter/cupertino.dart';
import './product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
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
    ),
  ];

  List<Product> get items {
    return [..._items];
  }
}
