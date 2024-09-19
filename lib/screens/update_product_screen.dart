import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../models/product.dart';

class UpdateProductScreen extends StatefulWidget {
  final Product product;

  const UpdateProductScreen({super.key, required this.product});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _productNameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _productNameTEController.text = widget.product.productName;
    _unitPriceTEController.text = widget.product.unitPrice;
    _totalPriceTEController.text = widget.product.totalPrice;
    _imageTEController.text = widget.product.productImage;
    _codeTEController.text = widget.product.productCode;
    _quantityTEController.text = widget.product.quantity;
  }

  Future<void> _updateProduct() async {
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/UpdateProduct/${widget.product.id}');

    Map<String, dynamic> requestBody = {
      "Img": _imageTEController.text,
      "ProductCode": _codeTEController.text,
      "ProductName": _productNameTEController.text,
      "Qty": _quantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitPriceTEController.text
    };

    try {
      Response response = await post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product updated successfully'))
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update product: ${response.body}'))
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error'))
      );
      print('Error: $error');
    }
  }


  void _onTapUpdateProductButton() {
    if (_formKey.currentState!.validate()) {
      _updateProduct();
    }
  }

  Widget _buildNewProductForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _productNameTEController,
            decoration: const InputDecoration(labelText: 'Product Name'),
            validator: (value) => value == null || value.isEmpty ? 'Please enter a product name' : null,
          ),
          TextFormField(
            controller: _unitPriceTEController,
            decoration: const InputDecoration(labelText: 'Unit Price'),
            validator: (value) => value == null || value.isEmpty ? 'Please enter a unit price' : null,
          ),
          TextFormField(
            controller: _totalPriceTEController,
            decoration: const InputDecoration(labelText: 'Total Price'),
            validator: (value) => value == null || value.isEmpty ? 'Please enter the total price' : null,
          ),
          TextFormField(
            controller: _imageTEController,
            decoration: const InputDecoration(labelText: 'Product Image'),
            validator: (value) => value == null || value.isEmpty ? 'Please enter an image URL' : null,
          ),
          TextFormField(
            controller: _codeTEController,
            decoration: const InputDecoration(labelText: 'Product Code'),
            validator: (value) => value == null || value.isEmpty ? 'Please enter a product code' : null,
          ),
          TextFormField(
            controller: _quantityTEController,
            decoration: const InputDecoration(labelText: 'Quantity'),
            validator: (value) => value == null || value.isEmpty ? 'Please enter quantity' : null,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _onTapUpdateProductButton,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(double.maxFinite),
            ),
            child: const Text('Update Product'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildNewProductForm(),
      ),
    );
  }

  @override
  void dispose() {
    _productNameTEController.dispose();
    _unitPriceTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    _codeTEController.dispose();
    _quantityTEController.dispose();
    super.dispose();
  }
}
