import 'package:crud_app_ostad/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductListScreen(),
    );
  }
}