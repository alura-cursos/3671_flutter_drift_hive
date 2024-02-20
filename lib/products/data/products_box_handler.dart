import 'package:flutter_listin/products/model/product.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductsBoxHandler {
  late Box _box;

  Future<void> openBox(String listinId) async {
    _box = await Hive.openBox(listinId);
  }

  Future<void> closeBox() async {
    return _box.close();
  }

  Future<int> insertProduct(Product product) async {
    return _box.add(product);
  }

  List<Product> getProdutcs() {
    return _box.values.map((elemento) => elemento as Product).toList();
  }
}
