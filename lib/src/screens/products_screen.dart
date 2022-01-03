import 'package:crud_flutter/src/services/product_service.dart';
import 'package:crud_flutter/src/models/product_model.dart';
import 'package:crud_flutter/src/providers/product_provider.dart';
import 'package:crud_flutter/src/screens/create_update_product_screen.dart';
import 'package:crud_flutter/src/widgets/products/product_admin_widget.dart';
import 'package:crud_flutter/src/widgets/streams/products_stream_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  void _createProduct(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const CreateUpdateProductScreen()));
  }

  void _showUpdateProductScreen(BuildContext context, Product product) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateUpdateProductScreen(product: product)));
  }

  void _selectItemToTrash(BuildContext context, Product product) {
    Provider.of<ProductProvider>(context, listen: false)
        .addProductsToDelete(product);
  }

  @override
  Widget build(BuildContext context) {
    List<String> _productsToDelete() =>
        Provider.of<ProductProvider>(context, listen: false).productsToDelete;

    void _clearProvider() {
      Provider.of<ProductProvider>(context, listen: false)
          .clearProductsToDelete();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Crud de productos'),
        actions: [
          if (!Provider.of<ProductProvider>(context).productsToDeleteIsEmpty())
            InkWell(
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('¿Estas seguro?'),
                        content: const Text(
                            '¿Estas seguro que desea eliminar estos elementos?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              deleteProducts(_productsToDelete(), context);
                              _clearProvider();
                            },
                            child: const Text('Si'),
                          ),
                        ],
                      )),
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Row(
                  children: [
                    Text(
                        "${Provider.of<ProductProvider>(context).productsToDelete.length}"),
                    const Icon(FontAwesomeIcons.trash),
                  ],
                ),
              ),
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ProductsSreamWidget(
          view: ({required Product product}) => ProductAdminWidget(
            product: product,
            onTap: (BuildContext context, Product product) {
              if (Provider.of<ProductProvider>(context, listen: false)
                  .productsToDelete
                  .contains(product.id)) {
                Provider.of<ProductProvider>(context, listen: false)
                    .removeProductsToDelete(product);
              } else if (!Provider.of<ProductProvider>(context, listen: false)
                  .productsToDeleteIsEmpty()) {
                Provider.of<ProductProvider>(context, listen: false)
                    .addProductsToDelete(product);
              } else {
                _showUpdateProductScreen(context, product);
              }
            },
            onLongPress: _selectItemToTrash,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(FontAwesomeIcons.plus),
        elevation: 15.0,
        onPressed: () => _createProduct(context),
      ),
    );
  }
}
