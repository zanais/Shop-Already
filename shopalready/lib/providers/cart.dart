import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int cantidad;
  final int price;

  CartItem({
    required this.id,
    required this.title,
    required this.cantidad,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items;

  Map<String, CartItem> items{
    return {..._items};
  }

  void addItem(String productId, int price, String title){
    if(_items.containsKey(productId)){
      _items.update(productId, (existingCartItem)=> CartItem(id: existingCartItem.id, title: existingCartItem.title, cantidad: existingCartItem.cantidad +1, price: existingCartItem.price,),);
    }
    else{
      _items.putIfAbsent(productId, ()=>CartItem(id: DateTime.now().toString(), title: title, price: price, cantidad: 1,),);
    }

  }
}
