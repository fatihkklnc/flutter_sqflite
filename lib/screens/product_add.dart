import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqflite_ilk/data/dbHelper.dart';
import 'package:flutter_sqflite_ilk/models/product.dart';
import 'package:flutter_sqflite_ilk/screens/validation.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductAddState();
  }
}

class ProductAddState extends State with ValidationMixin{
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();
  var FormKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("yeni ilaç ekle"),
      ),
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Form(
          key: FormKey,

          child: Column(
            children: <Widget>[
              buildNameField(),
              buildDescriptionField(),
              buildUnitPriceField(),

            ],
          ),
        )

      ),
      floatingActionButton: buildSaveButton(),
    );
  }

  Widget buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "ilaç Adı"),
      controller: txtName,
      validator: validateName,

    );
  }

  Widget buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "ilaç açıklaması"),
      controller: txtDescription,
      validator: validateDescription,
    );
  }

  Widget buildUnitPriceField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "ilaç adeti"),
      controller: txtUnitPrice,
      validator: validateUnitPrace,

    );
  }

  Widget buildSaveButton() {
    return RaisedButton(
      color: Colors.lightBlueAccent,
      child: Text("ekle"),
      onPressed: () {
        if(FormKey.currentState.validate()) {
          FormKey.currentState.save();
          addProduct();
        } },
    );
  }

  void addProduct() async {
    var result = await dbHelper.insert(Product(
        name: txtName.text,
        description: txtDescription.text,
        unitPrice: int.tryParse(txtUnitPrice.text)));
    Navigator.pop(context, true);
  }
}
