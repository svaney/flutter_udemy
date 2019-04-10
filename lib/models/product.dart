import 'package:flutter/material.dart';

class Product {
  final String title;
  final String image;
  final String description;
  final double price;
  final bool isFavorite;
  final String userId;
  final String userEmail;
  final String id;

  Product({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.description,
    @required this.price,
    @required this.userId,
    @required this.userEmail,
    this.isFavorite = false,

  });
}
