
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SnackCategories extends StatefulWidget {
  const SnackCategories({Key? key, this.snack}) : super(key: key);
  final dynamic snack;

  @override
  State<SnackCategories> createState() => _SnackCategoriesState();
}

class _SnackCategoriesState extends State<SnackCategories> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Coming soon', style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),),),
    );
  }
}
