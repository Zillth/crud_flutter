import 'package:crud_flutter/src/services/product_service.dart';
import 'package:crud_flutter/src/models/product_model.dart';
import 'package:crud_flutter/src/widgets/general/buttons_label_widget.dart';
import 'package:crud_flutter/src/widgets/general/inputs_widget.dart';
import 'package:crud_flutter/src/widgets/general/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateUpdateProductScreen extends StatefulWidget {
  final Product? product;
  const CreateUpdateProductScreen({Key? key, this.product}) : super(key: key);

  @override
  _CreateUpdateProductScreenState createState() =>
      _CreateUpdateProductScreenState();
}

class _CreateUpdateProductScreenState extends State<CreateUpdateProductScreen> {
  late TextEditingController _name;
  late TextEditingController _description;
  late TextEditingController _price;
  late TextEditingController _stock;

  late FocusNode initialFocus;

  @override
  void initState() {
    super.initState();
    initialFocus = FocusNode();
    _name = TextEditingController(
        text: widget.product != null ? widget.product!.name : '');
    _description = TextEditingController(
        text: widget.product != null ? widget.product!.description : '');
    _price = TextEditingController(
        text: widget.product != null ? widget.product!.price.toString() : '');
    _stock = TextEditingController(
        text: widget.product != null ? widget.product!.stock.toString() : '');
  }

  @override
  void dispose() {
    initialFocus.dispose();
    _name.dispose();
    _description.dispose();
    _price.dispose();
    _stock.dispose();
    super.dispose();
  }

  void _clearInputs() {
    _name.text = '';
    _description.text = '';
    _price.text = '';
    _stock.text = '';
    initialFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: widget.product != null
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: InkWell(
                    onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('¿Estas seguro?'),
                              content: Text(
                                  '¿Estas seguro que desea el elemento ${widget.product!.name}?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deleteProduct(widget.product!, context);
                                  },
                                  child: const Text('Si'),
                                ),
                              ],
                            )),
                    child: const Icon(FontAwesomeIcons.trash),
                  ),
                )
              ]
            : [],
      ),
      body: Center(
        child: SizedBox(
          height: 600.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: widget.product != null
                      ? const TitleWidget(text: 'Modificar Producto')
                      : const TitleWidget(text: 'Crear Producto'),
                ),
                InputWidget(
                  controller: _name,
                  iconData: FontAwesomeIcons.palette,
                  label: 'Nombre del producto',
                  focusNode: initialFocus,
                  textInputAction: TextInputAction.next,
                ),
                InputWidget(
                  controller: _description,
                  iconData: FontAwesomeIcons.folder,
                  label: 'Descripción del producto',
                  textInputAction: TextInputAction.next,
                ),
                InputWidget(
                  controller: _price,
                  iconData: FontAwesomeIcons.dollarSign,
                  label: 'Precio del producto',
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                ),
                InputWidget(
                  controller: _stock,
                  iconData: FontAwesomeIcons.box,
                  label: 'Stock del producto',
                  textInputType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        color: Colors.blue,
        child: InkWell(
          onTap: () {
            if (widget.product != null) {
              updateProduct(
                  Product(
                    id: widget.product!.id,
                    description: _description.text,
                    name: _name.text,
                    price: double.parse(_price.text),
                    stock: int.parse(_stock.text),
                  ),
                  context);
            } else {
              createProduct(
                  Product(
                    description: _description.text,
                    name: _name.text,
                    price: double.parse(_price.text),
                    stock: int.parse(_stock.text),
                  ),
                  context);
              _clearInputs();
            }
          },
          child: Center(
            child: ButtonLabelWidget(
              text: widget.product != null ? 'Modificar' : 'Crear',
            ),
          ),
        ),
      ),
    );
  }
}
