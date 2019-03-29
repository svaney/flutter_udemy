import 'package:flutter/material.dart';

class TitleDefault extends StatelessWidget {
  final String title;
  final bool multiline;

  TitleDefault(this.title, {this.multiline = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: !multiline ? TextOverflow.ellipsis : null,
      style: TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Oswald',
      ),
    );
  }
}
