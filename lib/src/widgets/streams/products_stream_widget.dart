import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter/src/services/product_service.dart';
import 'package:crud_flutter/src/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductsSreamWidget extends StatefulWidget {
  final Function view;
  const ProductsSreamWidget({Key? key, required this.view}) : super(key: key);

  @override
  _ProductsSreamWidgetState createState() => _ProductsSreamWidgetState();
}

class _ProductsSreamWidgetState extends State<ProductsSreamWidget> {
  final Stream<QuerySnapshot> _productsStream = getProductsStream();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              heightFactor: 15.0,
              child: Text('Algo ocurrio, intentalo más tarde'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              heightFactor: 15.0,
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              Product product = Product.fromJson(document.id, data);
              return AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: widget.view(product: product),
              );
            }).toList(),
          );
        });
  }
}
