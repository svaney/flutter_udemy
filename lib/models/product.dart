import 'package:flutter/material.dart';

class Product {
  final String title;
  final String image;
  final String description;
  final double price;
  final bool isFavorite;

  Product({
    @required this.title,
    @required this.image,
    @required this.description,
    @required this.price,
    this.isFavorite = false,
  });
}
