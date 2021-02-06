import 'package:flutter/material.dart';
import 'package:flutter_sqflite_ilk/data/dbHelper.dart';
import 'package:flutter_sqflite_ilk/models/product.dart';
import 'package:flutter_sqflite_ilk/screens/product_add.dart';
import 'package:flutter_sqflite_ilk/screens/validation.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

enum Options { delete, update }

class _ProductDetailState extends State with ValidationMixin {
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();
  var Formkey=GlobalKey<FormState>();
  Product product;
  _ProductDetailState(this.product);
  @override
  void initState() {
    txtName.text = product.name;
    txtDescription.text = product.description;
    txtUnitPrice.text = product.unitPrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İlaç detayı:${product.name}"),
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Sil"),

              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Güncelle"),
              )
            ],
          )
        ],
      ),
      body: buildProductDetail(),
    );
  }

  buildProductDetail() {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Form(
        key:Formkey,
        child: Column(
          children: <Widget>[
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),

          ],
        ),
      ),

    );
  }

  Widget buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "ilaç Adı"),
      validator: validateName,
      controller: txtName,
    );
  }

  Widget buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "ilaç açıklaması"),
      validator: validateDescription,
      controller: txtDescription,
    );
  }

  Widget buildUnitPriceField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "ilaç adeti"),
      validator: validateUnitPrace,
      controller: txtUnitPrice,
    );
  }

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(product.id);

          Navigator.pop(context, true);

        break;
      case Options.update:
        await dbHelper.update(Product.witdId(
            id: product.id,
            name: txtName.text,
            description: txtDescription.text,
            unitPrice: int.tryParse(txtUnitPrice.text)));
    if(Formkey.currentState.validate()) {
      Formkey.currentState.save();
      Navigator.pop(context, true);
    }
        break;
      default:
    }
  }
}
