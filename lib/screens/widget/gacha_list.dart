import 'package:flutter/material.dart';
import 'package:unknow_application/models/product.dart';

class GachaListWidget extends StatefulWidget {
  final String title;
  final List<Product> items; // Danh sách các phần tử truyền vào tùy biến

  const GachaListWidget({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  State<GachaListWidget> createState() => _GachaListWidgetState();
}

class _GachaListWidgetState extends State<GachaListWidget>{
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }

}