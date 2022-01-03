import 'package:crud_flutter/src/models/product_model.dart';
import 'package:crud_flutter/src/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductAdminWidget extends StatefulWidget {
  final Product product;
  final Function? onTap;
  final Function? onLongPress;
  const ProductAdminWidget(
      {Key? key, required this.product, this.onTap, this.onLongPress})
      : super(key: key);

  @override
  _ProductAdminWidgetState createState() => _ProductAdminWidgetState();
}

class _ProductAdminWidgetState extends State<ProductAdminWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(8.0),
      color: Provider.of<ProductProvider>(context)
              .productsToDelete
              .contains(widget.product.id as String)
          ? Colors.blue[200]
          : Colors.white,
      child: ListTile(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!(context, widget.product);
          }
        },
        onLongPress: () {
          if (widget.onLongPress != null) {
            widget.onLongPress!(context, widget.product);
          }
        },
        title: Text(
          widget.product.name,
          style: const TextStyle(fontSize: 18.0),
        ),
        subtitle: Text(
          widget.product.description,
          style: const TextStyle(fontSize: 18.0),
        ),
        trailing: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Text(
                '\s ${widget.product.price.toString()}',
                style: const TextStyle(fontSize: 20.0),
              ),
              Text(
                'Stock: ${widget.product.stock.toString()}',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
