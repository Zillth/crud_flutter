import 'package:crud_flutter/src/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final List<String> productsToDelete = [];

  void addProductsToDelete(Product product) {
    if (!productsToDelete.contains(product.id)) {
      productsToDelete.add(product.id as String);
      notifyListeners();
    }
  }

  void removeProductsToDelete(Product product) {
    if (productsToDelete.contains(product.id)) {
      productsToDelete.remove(product.id);
      notifyListeners();
    }
  }

  void clearProductsToDelete() {
    productsToDelete.clear();
    notifyListeners();
  }

  bool productsToDeleteIsEmpty() {
    return productsToDelete.isEmpty;
  }
}
