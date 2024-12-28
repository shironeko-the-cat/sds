import 'package:flutter/material.dart';
import 'models.dart';
import 'api.dart';

class ItemFormScreen extends StatefulWidget {
  final ItemModel? item;

  const ItemFormScreen({super.key, this.item});

  @override
  _ItemFormScreenState createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  late TextEditingController field1Controller;
  late TextEditingController field2Controller;
  late TextEditingController field3Controller;
  late TextEditingController optionalField1Controller;
  late TextEditingController optionalField2Controller;

  @override
  void initState() {
    super.initState();
    field1Controller = TextEditingController(text: widget.item?.firstName ?? '');
    field2Controller = TextEditingController(text: widget.item?.lastName ?? '');
    field3Controller = TextEditingController(text: widget.item?.email ?? '');
    optionalField1Controller =
        TextEditingController(text: widget.item?.phoneNumber ?? '');
    optionalField2Controller =
        TextEditingController(text: widget.item?.zipCode ?? '');
  }

  @override
  void dispose() {
    field1Controller.dispose();
    field2Controller.dispose();
    field3Controller.dispose();
    optionalField1Controller.dispose();
    optionalField2Controller.dispose();
    super.dispose();
  }

  Future<void> saveItem() async {
    if (_formKey.currentState!.validate()) {
      final item = ItemModel(
        id: widget.item?.id ?? 0,
        firstName: field1Controller.text,
        lastName: field2Controller.text,
        email: field3Controller.text,
        phoneNumber: optionalField1Controller.text,
        zipCode: optionalField2Controller.text,
      );

      try {
        if (widget.item == null) {
          await apiService.createItem(item);
        } else {
          await apiService.updateItem(widget.item!.id,item);
        }
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $e'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Add Item' : 'Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: field1Controller,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) =>
                    value!.isEmpty ? 'First Name is required' : null,
              ),
              TextFormField(
                controller: field2Controller,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Last Name is required' : null,
              ),
              TextFormField(
                controller: field3Controller,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value!.isEmpty ? 'Email is required' : null,
              ),
              TextFormField(
                controller: optionalField1Controller,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextFormField(
                controller: optionalField2Controller,
                decoration: InputDecoration(labelText: 'Zipcode'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveItem,
                child: Text(widget.item == null ? 'Create' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
