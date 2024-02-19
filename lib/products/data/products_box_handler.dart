import 'package:hive_flutter/hive_flutter.dart';

class ProductsBoxHandler {
  late Box _box;

  Future<void> openBox(String listinId) async {
    _box = await Hive.openBox(listinId);
  }

  Future<void> closeBox() async {
    return _box.close();
  }
}
