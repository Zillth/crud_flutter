import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter/src/models/product_model.dart';
import 'package:crud_flutter/src/widgets/general/snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final CollectionReference products =
    FirebaseFirestore.instance.collection('products');

Future<bool> productExist(Product product) {
  return products
      .limit(1)
      .where('name', isEqualTo: product.name)
      .get()
      .then((value) => value.docs.isNotEmpty);
}

Future<void> createProduct(Product product, BuildContext context) {
  return productExist(product).then((exist) {
    if (!exist) {
      return products.add(product.toJson()).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBarSuccess(text: "Nuevo producto añadido").snackBar);
      }).catchError((onError) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBarSuccess(text: "Fallo al añadir nuevo producto")
                .snackBar);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBarSuccess(
              text: "El producto con el nombre ${product.name} ya existe")
          .snackBar);
    }
  });
}

Future<void> updateProduct(Product product, BuildContext context) {
  return products.doc(product.id).update(product.toJson()).then((value) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBarSuccess(text: "Producto modificado").snackBar);
  }).catchError((onError) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBarSuccess(text: "Fallo al modificar producto").snackBar);
  });
}

Future<void> deleteProduct(Product product, BuildContext context) {
  return products.doc(product.id).delete().then((value) {
    Navigator.pop(context);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBarSuccess(text: "Producto eliminado").snackBar);
  }).catchError((onError) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBarSuccess(text: "Fallo al eliminar producto").snackBar);
  });
}

void deleteProducts(List<String> productsId, BuildContext context) {
  for (var productId in productsId) {
    products.doc(productId).delete().catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBarSuccess(text: "Fallo al eliminar productos").snackBar);
    });
  }
  Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBarSuccess(text: "Productos eliminados").snackBar);
}

Stream<QuerySnapshot> getProductsStream() => products.snapshots();
